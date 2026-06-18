package com.girlified.girlified

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.WindowManager
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import com.girlified.girlified.moderation.FullPageWarningOverlayManager

class SaifeAccessibilityService : AccessibilityService() {

    private val TAG = "SaifeAccessibility"
    private val DETECT_TAG = "SAFETY_APP_DETECT"
    private var windowManager: WindowManager? = null
    private var fullPageOverlayManager: FullPageWarningOverlayManager? = null
    private var isProtectionActive = false
    private var blockSuppressedUntilMs: Long = 0L
    private val blockSuppressDurationMs = 45_000L

    private val targetApps = setOf(
        "com.zhiliaoapp.musically",
        "com.instagram.android",
        "com.google.android.youtube",
        "com.twitter.android",
        "com.x.android",
        "com.snapchat.android",
    )

    private val controlReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            when (intent?.action) {
                "com.girlified.saife.SET_PROTECTION" -> {
                    val active = intent.getBooleanExtra("active", false)
                    isProtectionActive = active
                    if (!active) {
                        fullPageOverlayManager?.dismiss()
                    } else {
                        scheduleUpdate()
                    }
                    Log.d(TAG, "Protection active set to: $isProtectionActive via broadcast")
                }
                "com.girlified.saife.DISMISS_BLOCK_OVERLAY" -> {
                    fullPageOverlayManager?.dismiss()
                }
            }
        }
    }

    private val handler = Handler(Looper.getMainLooper())
    private var pendingUpdate = false
    private val updateRunnable = Runnable {
        pendingUpdate = false
        updateContentModeration()
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        Log.d(TAG, "Girlified Accessibility Service Connected")

        val info = AccessibilityServiceInfo().apply {
            eventTypes = AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED or
                AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED or
                AccessibilityEvent.TYPE_VIEW_SCROLLED
            feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
            flags = AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS or
                AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS
            notificationTimeout = 50
            packageNames = targetApps.toTypedArray()
        }

        serviceInfo = info
        isProtectionActive = true
        windowManager = getSystemService(Context.WINDOW_SERVICE) as WindowManager
        fullPageOverlayManager = windowManager?.let { wm ->
            FullPageWarningOverlayManager(
                windowManager = wm,
                context = this,
                onContinue = { onContinueInSocialApp() },
                onExitApp = { exitSocialMediaApp() },
            )
        }

        try {
            val filter = IntentFilter().apply {
                addAction("com.girlified.saife.SET_PROTECTION")
                addAction("com.girlified.saife.DISMISS_BLOCK_OVERLAY")
            }
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                registerReceiver(controlReceiver, filter, Context.RECEIVER_NOT_EXPORTED)
            } else {
                registerReceiver(controlReceiver, filter)
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error registering receiver", e)
        }

        Log.d(TAG, "Service configured to monitor: ${targetApps.joinToString()}")
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (!isProtectionActive || event == null) return

        val packageName = event.packageName?.toString() ?: return
        if (!targetApps.contains(packageName)) {
            return
        }

        val prefs = getSharedPreferences("GirlifiedPrefs", Context.MODE_PRIVATE)
        if (!prefs.getBoolean("accessibility_monitoring_enabled", true)) {
            fullPageOverlayManager?.dismiss()
            return
        }

        scheduleUpdate()
    }

    private fun scheduleUpdate() {
        if (!pendingUpdate) {
            pendingUpdate = true
            handler.postDelayed(updateRunnable, 50)
        }
    }

    private fun getActiveKeywords(): Set<String> {
        val prefs = getSharedPreferences("GirlifiedPrefs", Context.MODE_PRIVATE)
        val stored = prefs.getStringSet("protection_keywords", emptySet()) ?: emptySet()
        return stored.map { it.trim().lowercase() }.filter { it.isNotEmpty() }.toSet()
    }

    private fun updateContentModeration() {
        try {
            val manager = fullPageOverlayManager ?: return

            if (System.currentTimeMillis() < blockSuppressedUntilMs) {
                if (manager.isShowing) manager.dismiss()
                return
            }

            if (manager.isShowing) return

            val rootNode = rootInActiveWindow ?: return
            val activeKeywords = getActiveKeywords()
            val currentPackage = rootNode.packageName?.toString() ?: "unknown"

            if (activeKeywords.isEmpty()) {
                manager.dismiss()
                return
            }

            val allScrapedTexts = mutableListOf<String>()
            var matchedKeyword = ""

            collectTextsAndMatch(rootNode, activeKeywords, allScrapedTexts) { keyword ->
                matchedKeyword = keyword
            }

            if (allScrapedTexts.isNotEmpty()) {
                sendScrapedTextsToFlutter(allScrapedTexts, currentPackage)
            }

            if (matchedKeyword.isEmpty()) {
                return
            }

            val metrics = resources.displayMetrics
            val shown = manager.show(matchedKeyword, metrics.widthPixels, metrics.heightPixels)
            if (shown) {
                sendContentBlockedBroadcast(currentPackage)
                Log.d(DETECT_TAG, "Full-page block shown for keyword=$matchedKeyword")
            }
        } catch (e: Exception) {
            Log.e(DETECT_TAG, "Error during content moderation — skipping pass", e)
        }
    }

    private fun collectTextsAndMatch(
        node: AccessibilityNodeInfo,
        keywords: Set<String>,
        allScrapedTexts: MutableList<String>,
        onMatch: (String) -> Unit,
    ) {
        try {
            if (node.isVisibleToUser) {
                listOfNotNull(node.text?.toString(), node.contentDescription?.toString())
                    .forEach { raw ->
                        if (raw.isBlank()) return@forEach
                        allScrapedTexts.add(raw)
                        findMatchedKeyword(raw, keywords)?.let(onMatch)
                    }
            }
            for (i in 0 until node.childCount) {
                val child = node.getChild(i) ?: continue
                collectTextsAndMatch(child, keywords, allScrapedTexts, onMatch)
            }
        } catch (e: Exception) {
            Log.w(DETECT_TAG, "Node traversal error — continuing", e)
        }
    }

    private fun findMatchedKeyword(text: String, keywords: Set<String>): String? {
        val lowerText = text.lowercase()
        return keywords.firstOrNull { lowerText.contains(it) }
    }

    private fun onContinueInSocialApp() {
        Log.d(DETECT_TAG, "Continue — dismissing block, user stays in social app")
        blockSuppressedUntilMs = System.currentTimeMillis() + blockSuppressDurationMs
        handler.removeCallbacks(updateRunnable)
        pendingUpdate = false
    }

    private fun exitSocialMediaApp() {
        Log.d(DETECT_TAG, "Exit App — leaving social media app")
        blockSuppressedUntilMs = System.currentTimeMillis() + blockSuppressDurationMs
        handler.removeCallbacks(updateRunnable)
        pendingUpdate = false
        try {
            performGlobalAction(GLOBAL_ACTION_HOME)
        } catch (e: Exception) {
            Log.e(DETECT_TAG, "Failed to exit social app via HOME", e)
        }
    }

    private fun sendScrapedTextsToFlutter(texts: List<String>, packageName: String) {
        try {
            val intent = Intent("com.girlified.saife.TEXT_SCRAPED").apply {
                setPackage(applicationContext.packageName)
                putStringArrayListExtra("texts", ArrayList(texts))
                putExtra("package", packageName)
                putExtra("timestamp", System.currentTimeMillis())
            }
            sendBroadcast(intent)
        } catch (e: Exception) {
            Log.e(DETECT_TAG, "Error sending scraped texts to Flutter", e)
        }
    }

    private fun sendContentBlockedBroadcast(packageName: String) {
        try {
            val intent = Intent("com.girlified.saife.CONTENT_BLOCKED").apply {
                setPackage(applicationContext.packageName)
                putExtra("event", "content_blocked")
                putExtra("data", packageName)
                putExtra("timestamp", System.currentTimeMillis())
            }
            sendBroadcast(intent)
        } catch (e: Exception) {
            Log.e(DETECT_TAG, "Error sending content blocked broadcast", e)
        }
    }

    override fun onInterrupt() {
        Log.d(TAG, "Girlified Service Interrupted")
        isProtectionActive = false
        fullPageOverlayManager?.dismiss()
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "Girlified Service Destroyed")
        isProtectionActive = false
        fullPageOverlayManager?.dismiss()
        try {
            unregisterReceiver(controlReceiver)
        } catch (_: Exception) {
        }
    }

    companion object {
        const val EXTRA_OPEN_PROTECTION_DASHBOARD = "open_protection_dashboard"

        fun isServiceEnabled(context: Context): Boolean {
            val packageName = context.packageName
            val serviceName = "$packageName/${SaifeAccessibilityService::class.java.canonicalName}"
            val enabledServices = android.provider.Settings.Secure.getString(
                context.contentResolver,
                android.provider.Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES,
            ) ?: return false
            return enabledServices.contains(serviceName)
        }
    }
}
