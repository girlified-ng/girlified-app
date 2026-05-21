package com.girlified.girlified

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.graphics.Color
import android.graphics.PixelFormat
import android.graphics.Rect
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
    private var windowManager: WindowManager? = null
    private var isProtectionActive = false
    private val activeOverlays = mutableListOf<View>()

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
            registerReceiver(protectionReceiver, filter)
        } catch (e: Exception) {
            Log.e(TAG, "Error registering receiver", e)
        }
        
        Log.d(TAG, "Service configured to monitor: ${targetApps.joinToString()}")
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (!isProtectionActive || event == null) return
        
        val packageName = event.packageName?.toString() ?: return
        
        // Only process events from target apps
        if (!targetApps.contains(packageName)) {
            clearOverlays()
            return
        }

        val prefs = getSharedPreferences("GirlifiedPrefs", Context.MODE_PRIVATE)
        val isEnabled = prefs.getBoolean("accessibility_monitoring_enabled", true)
        if (!isEnabled) {
            clearOverlays()
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
        val defaultKeywords = setOf(
            "violence", "violent", "kill", "hurt", "attack", "abuse",
            "hate", "harassment", "bully", "threat", "weapon",
            "explicit", "graphic", "disturbing"
        )
        val prefs = getSharedPreferences("GirlifiedPrefs", Context.MODE_PRIVATE)
        val customKeywords = prefs.getStringSet("protection_keywords", null) ?: emptySet()
        return defaultKeywords + customKeywords
    }

    private fun updateRedactionOverlays() {
        val rootNode = rootInActiveWindow ?: return
        val activeKeywords = getActiveKeywords()
        
        // Find all matching nodes containing keywords
        val matchingNodes = mutableListOf<AccessibilityNodeInfo>()
        findMatchingNodes(rootNode, activeKeywords, matchingNodes)
        
        // Clear current overlays
        clearOverlays()
        
        // Get screen dimensions to avoid drawing offscreen/empty rects
        val displayMetrics = resources.displayMetrics
        val screenWidth = displayMetrics.widthPixels
        val screenHeight = displayMetrics.heightPixels
        
        var blockedAny = false
        var blockedCategory = "Harmful Content"
        
        for (node in matchingNodes) {
            val rect = Rect()
            node.getBoundsInScreen(rect)
            
            // Validate bounds are inside the screen
            if (rect.width() > 0 && rect.height() > 0 && 
                rect.left >= 0 && rect.top >= 0 && 
                rect.right <= screenWidth && rect.bottom <= screenHeight) {
                
                addRedactOverlay(rect)
                blockedAny = true
                
                val text = node.text?.toString()?.lowercase() ?: ""
                blockedCategory = determineCategory(text)
            }
        }
        
        if (blockedAny) {
            val currentPackage = rootNode.packageName?.toString() ?: "Social App"
            sendNotificationToFlutter("content_blocked", currentPackage)
        }
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

    private fun findMatchingNodes(node: AccessibilityNodeInfo, keywords: Set<String>, result: MutableList<AccessibilityNodeInfo>) {
        if (node.isVisibleToUser) {
            val text = node.text?.toString()?.lowercase()
            val desc = node.contentDescription?.toString()?.lowercase()
            
            val matchesText = text != null && keywords.any { text.contains(it) }
            val matchesDesc = desc != null && keywords.any { desc.contains(it) }
            
            if (matchesText || matchesDesc) {
                result.add(node)
            }
        }
        
        for (i in 0 until node.childCount) {
            val child = node.getChild(i)
            if (child != null) {
                findMatchingNodes(child, keywords, result)
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

    private fun addRedactOverlay(rect: Rect) {
        val context = this
        val overlayView = TextView(context).apply {
            text = "⚠️ [Redacted]"
            setTextColor(Color.WHITE)
            gravity = Gravity.CENTER
            textSize = 10f
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#FC1A1625")) // Dark purple background
                cornerRadius = 8f
                setStroke(2, Color.parseColor("#8B5CF6")) // Electric Lilac border
            }
            setPadding(6, 2, 6, 2)
        }

        val params = WindowManager.LayoutParams(
            rect.width(),
            rect.height(),
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
            } else {
                @Suppress("DEPRECATION")
                WindowManager.LayoutParams.TYPE_SYSTEM_ALERT
            },
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                    WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE or
                    WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN,
            PixelFormat.TRANSLUCENT
        ).apply {
            gravity = Gravity.TOP or Gravity.LEFT
            x = rect.left
            y = rect.top
        }

        try {
            windowManager?.addView(overlayView, params)
            activeOverlays.add(overlayView)
        } catch (e: Exception) {
            Log.e(TAG, "Failed to add overlay at rect $rect", e)
        }
    }

    private fun sendNotificationToFlutter(event: String, data: String) {
        try {
            val intent = Intent("com.girlified.saife.CONTENT_BLOCKED").apply {
                putExtra("event", event)
                putExtra("data", data)
                putExtra("timestamp", System.currentTimeMillis())
            }
            sendBroadcast(intent)
        } catch (e: Exception) {
            Log.e(TAG, "Error sending notification to Flutter", e)
        }
    }

    override fun onInterrupt() {
        Log.d(TAG, "Girlified Service Interrupted")
        isProtectionActive = false
        clearOverlays()
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "Girlified Service Destroyed")
        isProtectionActive = false
        clearOverlays()
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
