package com.girlified.girlified

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Intent
import android.graphics.Bitmap
import android.graphics.PixelFormat
import android.os.Build
import android.util.Log
import android.view.WindowManager
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import androidx.annotation.RequiresApi
import java.io.File
import java.io.FileOutputStream

class SaifeAccessibilityService : AccessibilityService() {

    private val TAG = "SaifeAccessibility"
    private var overlayService: OverlayService? = null
    private var isProtectionActive = false
    
    // Target apps to monitor
    private val targetApps = setOf(
        "com.zhiliaoapp.musically",      // TikTok
        "com.instagram.android",         // Instagram
        "com.google.android.youtube"     // YouTube
    )

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
            
            notificationTimeout = 100
            packageNames = targetApps.toTypedArray()
        }
        
        serviceInfo = info
        isProtectionActive = true
        
        // Initialize overlay service
        overlayService = OverlayService(this)
        
        Log.d(TAG, "Service configured to monitor: ${targetApps.joinToString()}")
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent?) {
        if (!isProtectionActive || event == null) return
        
        val packageName = event.packageName?.toString() ?: return
        
        // Only process events from target apps
        if (!targetApps.contains(packageName)) return
        
        when (event.eventType) {
            AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED,
            AccessibilityEvent.TYPE_VIEW_SCROLLED -> {
                Log.d(TAG, "Content changed in $packageName")
                analyzeContent(event, packageName)
            }
            AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED -> {
                Log.d(TAG, "Window state changed in $packageName")
            }
        }
    }

    private fun analyzeContent(event: AccessibilityEvent, packageName: String) {
        try {
            val rootNode = rootInActiveWindow ?: return
            
            // Extract text content from the screen
            val textContent = extractTextFromNode(rootNode)
            
            // Analyze text for harmful keywords
            val isHarmful = analyzeTextContent(textContent)
            
            if (isHarmful) {
                Log.w(TAG, "Harmful content detected in $packageName!")
                showBlurOverlay(packageName)
                sendNotificationToFlutter("content_blocked", packageName)
            }
            
            // In a real implementation, you would:
            // 1. Take a screenshot of the current window
            // 2. Process it with TFLite model
            // 3. If harmful content is detected, show overlay
            
        } catch (e: Exception) {
            Log.e(TAG, "Error analyzing content", e)
        }
    }

    private fun extractTextFromNode(node: AccessibilityNodeInfo): String {
        val builder = StringBuilder()
        
        fun traverse(currentNode: AccessibilityNodeInfo) {
            currentNode.text?.let { builder.append(it).append(" ") }
            currentNode.contentDescription?.let { builder.append(it).append(" ") }
            
            for (i in 0 until currentNode.childCount) {
                currentNode.getChild(i)?.let { traverse(it) }
            }
        }
        
        traverse(node)
        return builder.toString()
    }

    private fun analyzeTextContent(text: String): Boolean {
        // Simple keyword-based detection (in production, use TFLite model)
        val harmfulKeywords = setOf(
            "violence", "violent", "kill", "hurt", "attack", "abuse",
            "hate", "harassment", "bully", "threat", "weapon",
            "explicit", "graphic", "disturbing"
        )
        
        val lowerText = text.lowercase()
        return harmfulKeywords.any { keyword -> lowerText.contains(keyword) }
    }

    private fun showBlurOverlay(packageName: String) {
        overlayService?.showOverlay(packageName)
    }

    private fun sendNotificationToFlutter(event: String, data: String) {
        try {
            // Send broadcast to Flutter app
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
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "Girlified Service Destroyed")
        isProtectionActive = false
        overlayService?.hideOverlay()
    }

    fun setProtectionState(active: Boolean) {
        isProtectionActive = active
        Log.d(TAG, "Protection state: $isProtectionActive")
    }

    companion object {
        private const val SCREENSHOT_DIR = "saife_screenshots"
        
        fun isServiceEnabled(context: android.content.Context): Boolean {
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



