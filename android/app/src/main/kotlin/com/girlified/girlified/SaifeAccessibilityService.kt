package com.girlified.girlified

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.graphics.Rect
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.WindowManager
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import com.girlified.girlified.moderation.FlaggedContent
import com.girlified.girlified.moderation.InlineModerationState
import com.girlified.girlified.moderation.InlineOverlayManager

class SaifeAccessibilityService : AccessibilityService() {

    private val TAG = "SaifeAccessibility"
    private val DETECT_TAG = "SAFETY_APP_DETECT"
    private var windowManager: WindowManager? = null
    private var inlineOverlayManager: InlineOverlayManager? = null
    private var isProtectionActive = false

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
                        inlineOverlayManager?.resetSession()
                    } else {
                        scheduleUpdate()
                    }
                    Log.d(TAG, "Protection active set to: $isProtectionActive via broadcast")
                }
                "com.girlified.saife.DISMISS_BLOCK_OVERLAY" -> {
                    inlineOverlayManager?.clearAll()
                }
            }
        }
    }

    private val handler = Handler(Looper.getMainLooper())
    private var pendingUpdate = false
    private val updateRunnable = Runnable {
        pendingUpdate = false
        updateInlineModeration()
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
        inlineOverlayManager = windowManager?.let { InlineOverlayManager(it, this) }

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
            inlineOverlayManager?.clearAll()
            return
        }

        val prefs = getSharedPreferences("GirlifiedPrefs", Context.MODE_PRIVATE)
        if (!prefs.getBoolean("accessibility_monitoring_enabled", true)) {
            inlineOverlayManager?.clearAll()
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

    private fun updateInlineModeration() {
        try {
            val manager = inlineOverlayManager ?: return
            val rootNode = rootInActiveWindow ?: run {
                manager.clearAll()
                return
            }

            val activeKeywords = getActiveKeywords()
            val currentPackage = rootNode.packageName?.toString() ?: "unknown"

            if (activeKeywords.isEmpty()) {
                manager.clearAll()
                return
            }

            val allScrapedTexts = mutableListOf<String>()
            val flaggedItems = mutableListOf<FlaggedContent>()
            collectFlaggedContent(rootNode, activeKeywords, currentPackage, flaggedItems, allScrapedTexts)

            val dedupedFlagged = flaggedItems.distinctBy { it.key }

            Log.d(
                DETECT_TAG,
                "Inline moderation pass: texts=${allScrapedTexts.size} flagged=${dedupedFlagged.size}",
            )

            if (allScrapedTexts.isNotEmpty()) {
                sendScrapedTextsToFlutter(allScrapedTexts, currentPackage)
            }

            if (dedupedFlagged.isNotEmpty()) {
                manager.syncMasks(dedupedFlagged)
            } else {
                manager.syncMasks(emptyList())
            }
        } catch (e: Exception) {
            Log.e(DETECT_TAG, "Error during inline moderation — skipping pass", e)
        }
    }

    private fun collectFlaggedContent(
        node: AccessibilityNodeInfo,
        keywords: Set<String>,
        packageName: String,
        flaggedItems: MutableList<FlaggedContent>,
        allScrapedTexts: MutableList<String>,
    ) {
        try {
            if (node.isVisibleToUser) {
                val text = node.text?.toString()
                val desc = node.contentDescription?.toString()

                listOfNotNull(text, desc).forEach { raw ->
                    if (raw.isBlank()) return@forEach
                    allScrapedTexts.add(raw)
                    val matched = findMatchedKeyword(raw, keywords) ?: return@forEach

                    val bounds = Rect()
                    node.getBoundsInScreen(bounds)
                    if (bounds.width() <= 0 || bounds.height() <= 0) return@forEach

                    val key = InlineModerationState.buildPostKey(packageName, bounds, raw)
                    flaggedItems.add(FlaggedContent(key, bounds, matched))
                }
            }

            for (i in 0 until node.childCount) {
                val child = node.getChild(i) ?: continue
                collectFlaggedContent(child, keywords, packageName, flaggedItems, allScrapedTexts)
            }
        } catch (e: Exception) {
            Log.w(DETECT_TAG, "Node collection error — continuing", e)
        }
    }

    private fun findMatchedKeyword(text: String, keywords: Set<String>): String? {
        val lowerText = text.lowercase()
        return keywords.firstOrNull { lowerText.contains(it) }
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

    override fun onInterrupt() {
        Log.d(TAG, "Girlified Service Interrupted")
        isProtectionActive = false
        inlineOverlayManager?.resetSession()
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "Girlified Service Destroyed")
        isProtectionActive = false
        inlineOverlayManager?.resetSession()
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
