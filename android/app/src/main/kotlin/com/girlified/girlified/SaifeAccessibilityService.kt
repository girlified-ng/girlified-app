package com.girlified.girlified

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.graphics.Color
import android.graphics.PixelFormat
import android.graphics.drawable.GradientDrawable
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import android.widget.TextView

class SaifeAccessibilityService : AccessibilityService() {

    private val TAG = "SaifeAccessibility"
    private val DETECT_TAG = "SAFETY_APP_DETECT"
    private var windowManager: WindowManager? = null
    private var isProtectionActive = false
    private val activeOverlays = mutableListOf<View>()
    private var fullScreenBlockView: View? = null

    // Target apps to monitor
    private val targetApps = setOf(
        "com.zhiliaoapp.musically",      // TikTok
        "com.instagram.android",         // Instagram
        "com.google.android.youtube",    // YouTube
        "com.twitter.android",           // Twitter
        "com.x.android",                 // X/Twitter
        "com.snapchat.android"           // Snapchat
    )

    private val protectionReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent?.action == "com.girlified.saife.SET_PROTECTION") {
                val active = intent.getBooleanExtra("active", false)
                isProtectionActive = active
                if (!active) {
                    clearOverlays()
                    clearFullScreenBlockOverlay()
                } else {
                    scheduleUpdate()
                }
                Log.d(TAG, "Protection active set to: $isProtectionActive via broadcast")
            }
        }
    }

    private val handler = Handler(Looper.getMainLooper())
    private var pendingUpdate = false
    private val updateRunnable = Runnable {
        pendingUpdate = false
        updateRedactionOverlays()
    }

    override fun onServiceConnected() {
        super.onServiceConnected()
        Log.d(TAG, "Girlified Accessibility Service Connected")
        
        // Configure accessibility service
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

        // Register receiver for active state changes
        try {
            val filter = IntentFilter("com.girlified.saife.SET_PROTECTION")
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                registerReceiver(protectionReceiver, filter, Context.RECEIVER_NOT_EXPORTED)
            } else {
                registerReceiver(protectionReceiver, filter)
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error registering receiver", e)
        }
        
        Log.d(TAG, "Service configured to monitor: ${targetApps.joinToString()}")
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (!isProtectionActive || event == null) return

        val packageName = event.packageName?.toString() ?: return
        val eventType = AccessibilityEvent.eventTypeToString(event.eventType)

        // Only process events from target apps
        if (!targetApps.contains(packageName)) {
            clearOverlays()
            clearFullScreenBlockOverlay()
            return
        }

        val prefs = getSharedPreferences("GirlifiedPrefs", Context.MODE_PRIVATE)
        val isEnabled = prefs.getBoolean("accessibility_monitoring_enabled", true)
        if (!isEnabled) {
            Log.d(DETECT_TAG, "Monitoring disabled in prefs — skipping $packageName")
            clearOverlays()
            clearFullScreenBlockOverlay()
            return
        }

        Log.d(DETECT_TAG, "Accessibility event: type=$eventType package=$packageName")
        scheduleUpdate()
    }

    private fun scheduleUpdate() {
        if (!pendingUpdate) {
            pendingUpdate = true
            handler.postDelayed(updateRunnable, 50)
        }
    }

    private fun getActiveKeywords(): Set<String> {
        val defaultKeywords = setOf(
            "violence", "violent", "kill", "hurt", "attack", "abuse",
            "hate", "harassment", "harass", "bully", "bullying", "threat",
            "threaten", "threatening", "stalk", "stalking", "weapon",
            "explicit", "graphic", "disturbing",
        )
        val prefs = getSharedPreferences("GirlifiedPrefs", Context.MODE_PRIVATE)
        val customKeywords = prefs.getStringSet("protection_keywords", null) ?: emptySet()
        return defaultKeywords + customKeywords
    }

    private fun updateRedactionOverlays() {
        val rootNode = rootInActiveWindow
        if (rootNode == null) {
            Log.d(DETECT_TAG, "No active window root — skipping scrape")
            return
        }

        val activeKeywords = getActiveKeywords()
        val currentPackage = rootNode.packageName?.toString() ?: "unknown"
        Log.d(DETECT_TAG, "Starting screen scrape for package=$currentPackage keywords=${activeKeywords.size}")

        // Find all matching nodes containing keywords and collect all scraped texts
        val matchingNodes = mutableListOf<AccessibilityNodeInfo>()
        val allScrapedTexts = mutableListOf<String>()
        traverseAndProcessNodes(rootNode, activeKeywords, matchingNodes, allScrapedTexts)

        Log.d(
            DETECT_TAG,
            "Scrape complete: texts=${allScrapedTexts.size} keyword_matches=${matchingNodes.size}",
        )

        // Send scraped texts to Flutter
        if (allScrapedTexts.isNotEmpty()) {
            sendScrapedTextsToFlutter(allScrapedTexts, currentPackage)
        } else {
            Log.d(DETECT_TAG, "No visible text captured this pass")
        }
        
        // Clear per-node overlays from previous pass
        clearOverlays()

        // Get screen dimensions
        val displayMetrics = resources.displayMetrics
        val screenWidth = displayMetrics.widthPixels
        val screenHeight = displayMetrics.heightPixels

        var blockedAny = false
        var blockedCategory = "Harmful Content"
        var matchedKeyword = ""

        for (node in matchingNodes) {
            blockedAny = true
            val text = (node.text?.toString() ?: node.contentDescription?.toString() ?: "").lowercase()
            blockedCategory = determineCategory(text)
            matchedKeyword = findMatchedKeyword(text, activeKeywords) ?: matchedKeyword
        }

        if (blockedAny) {
            Log.d(DETECT_TAG, "Threat detected — showing full-screen block (keyword=$matchedKeyword)")
            showFullScreenBlockOverlay(currentPackage, matchedKeyword, blockedCategory, screenWidth, screenHeight)
            sendNotificationToFlutter("content_blocked", currentPackage)
            sendThreatDetectedBroadcast(currentPackage, matchedKeyword)
        } else {
            clearFullScreenBlockOverlay()
        }
    }

    private fun findMatchedKeyword(text: String, keywords: Set<String>): String? {
        return keywords.firstOrNull { text.contains(it) }
    }

    private fun sendThreatDetectedBroadcast(packageName: String, keyword: String) {
        try {
            val intent = Intent("com.girlified.saife.THREAT_DETECTED").apply {
                setPackage(applicationContext.packageName)
                putExtra("package", packageName)
                putExtra("keyword", keyword)
                putExtra("timestamp", System.currentTimeMillis())
            }
            sendBroadcast(intent)
        } catch (e: Exception) {
            Log.e(DETECT_TAG, "Error sending threat detected broadcast", e)
        }

    private fun determineCategory(text: String): String {
        if (text.contains("porn") || text.contains("nsfw") || text.contains("sex") || text.contains("nudes") || text.contains("onlyfans")) {
            return "Explicit Content"
        }
        if (text.contains("kill") || text.contains("suicide") || text.contains("unalive") || text.contains("sh") || text.contains("kys") || text.contains("kms")) {
            return "Self-Harm"
        }
        if (text.contains("violence") || text.contains("violent") || text.contains("murder") || text.contains("weapon") || text.contains("blood")) {
            return "Violence"
        }
        return "Harassment"
    }

    private fun sendScrapedTextsToFlutter(texts: List<String>, packageName: String) {
        try {
            val intent = Intent("com.girlified.saife.TEXT_SCRAPED").apply {
                setPackage(applicationContext.packageName)
                putStringArrayListExtra("texts", java.util.ArrayList(texts))
                putExtra("package", packageName)
                putExtra("timestamp", System.currentTimeMillis())
            }
            Log.d(DETECT_TAG, "Broadcasting ${texts.size} scraped strings to Flutter for $packageName")
            sendBroadcast(intent)
        } catch (e: Exception) {
            Log.e(DETECT_TAG, "Error sending scraped texts to Flutter", e)
        }
    }

    private fun traverseAndProcessNodes(
        node: AccessibilityNodeInfo,
        keywords: Set<String>,
        matchingNodes: MutableList<AccessibilityNodeInfo>,
        allScrapedTexts: MutableList<String>
    ) {
        if (node.isVisibleToUser) {
            val text = node.text?.toString()
            val desc = node.contentDescription?.toString()
            
            if (!text.isNullOrBlank()) {
                allScrapedTexts.add(text)
                Log.d(DETECT_TAG, "Captured node text: $text")
                
                val lowerText = text.lowercase()
                if (keywords.any { lowerText.contains(it) }) {
                    matchingNodes.add(node)
                }
            }
            
            if (!desc.isNullOrBlank()) {
                allScrapedTexts.add(desc)
                Log.d(DETECT_TAG, "Captured node contentDescription: $desc")
                
                val lowerDesc = desc.lowercase()
                if (keywords.any { lowerDesc.contains(it) }) {
                    matchingNodes.add(node)
                }
            }
        }
        
        for (i in 0 until node.childCount) {
            val child = node.getChild(i)
            if (child != null) {
                traverseAndProcessNodes(child, keywords, matchingNodes, allScrapedTexts)
            }
        }
    }

    private fun clearOverlays() {
        for (view in activeOverlays) {
            try {
                windowManager?.removeView(view)
            } catch (e: Exception) {
                // Ignore if already removed
            }
        }
        activeOverlays.clear()
    }

    private fun clearFullScreenBlockOverlay() {
        fullScreenBlockView?.let { view ->
            try {
                windowManager?.removeView(view)
            } catch (e: Exception) {
                // Ignore if already removed
            }
        }
        fullScreenBlockView = null
    }

    private fun showFullScreenBlockOverlay(
        appPackage: String,
        matchedKeyword: String,
        category: String,
        screenWidth: Int,
        screenHeight: Int,
    ) {
        if (fullScreenBlockView != null) return

        val container = android.widget.LinearLayout(this).apply {
            orientation = android.widget.LinearLayout.VERTICAL
            gravity = Gravity.CENTER
            setBackgroundColor(Color.parseColor("#E61A1625"))
            setPadding(48, 48, 48, 48)
        }

        val card = android.widget.LinearLayout(this).apply {
            orientation = android.widget.LinearLayout.VERTICAL
            gravity = Gravity.CENTER_HORIZONTAL
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#FF2D2640"))
                cornerRadius = 48f
                setStroke(4, Color.parseColor("#FF8B5CF6"))
            }
            setPadding(56, 56, 56, 56)
        }

        val icon = TextView(this).apply {
            text = "🛡️"
            textSize = 48f
            gravity = Gravity.CENTER
        }

        val title = TextView(this).apply {
            text = "Harmful Content Blocked"
            setTextColor(Color.WHITE)
            textSize = 22f
            gravity = Gravity.CENTER
            setPadding(0, 24, 0, 12)
        }

        val message = TextView(this).apply {
            text = if (matchedKeyword.isNotEmpty()) {
                "SaifeAI detected \"$matchedKeyword\" ($category) in $appPackage.\n\nTap below to dismiss this screen."
            } else {
                "SaifeAI intercepted harmful content in $appPackage.\n\nTap below to dismiss this screen."
            }
            setTextColor(Color.parseColor("#B3FFFFFF"))
            textSize = 14f
            gravity = Gravity.CENTER
            setPadding(0, 0, 0, 32)
        }

        val dismissButton = TextView(this).apply {
            text = "Dismiss & Continue"
            setTextColor(Color.WHITE)
            textSize = 16f
            gravity = Gravity.CENTER
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#FF8B5CF6"))
                cornerRadius = 28f
            }
            setPadding(48, 28, 48, 28)
            setOnClickListener {
                Log.d(DETECT_TAG, "Full-screen block dismissed by user")
                clearFullScreenBlockOverlay()
            }
        }

        card.addView(icon)
        card.addView(title)
        card.addView(message)
        card.addView(dismissButton)
        container.addView(card)

        val params = WindowManager.LayoutParams(
            screenWidth,
            screenHeight,
            WindowManager.LayoutParams.TYPE_ACCESSIBILITY_OVERLAY,
            WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN or
                    WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            PixelFormat.TRANSLUCENT,
        ).apply {
            gravity = Gravity.TOP or Gravity.START
            x = 0
            y = 0
        }

        try {
            windowManager?.addView(container, params)
            fullScreenBlockView = container
            Log.d(DETECT_TAG, "Full-screen block overlay displayed")
        } catch (e: Exception) {
            Log.e(DETECT_TAG, "Failed to show full-screen block — check overlay permission", e)
        }
    }

    private fun sendNotificationToFlutter(event: String, data: String) {
        try {
            val intent = Intent("com.girlified.saife.CONTENT_BLOCKED").apply {
                setPackage(applicationContext.packageName)
                putExtra("event", event)
                putExtra("data", data)
                putExtra("timestamp", System.currentTimeMillis())
            }
            Log.d(DETECT_TAG, "Broadcasting content_blocked to Flutter: $data")
            sendBroadcast(intent)
        } catch (e: Exception) {
            Log.e(DETECT_TAG, "Error sending notification to Flutter", e)
        }
    }

    override fun onInterrupt() {
        Log.d(TAG, "Girlified Service Interrupted")
        isProtectionActive = false
        clearOverlays()
        clearFullScreenBlockOverlay()
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "Girlified Service Destroyed")
        isProtectionActive = false
        clearOverlays()
        clearFullScreenBlockOverlay()
        try {
            unregisterReceiver(protectionReceiver)
        } catch (e: Exception) {}
    }

    fun setProtectionState(active: Boolean) {
        isProtectionActive = active
        Log.d(TAG, "Protection state: $isProtectionActive")
    }

    companion object {
        fun isServiceEnabled(context: Context): Boolean {
            val packageName = context.packageName
            val serviceName = "$packageName/${SaifeAccessibilityService::class.java.canonicalName}"
            
            val enabledServices = android.provider.Settings.Secure.getString(
                context.contentResolver,
                android.provider.Settings.Secure.ENABLED_ACCESSIBILITY_SERVICES
            ) ?: return false
            
            return enabledServices.contains(serviceName)
        }
    }
}
