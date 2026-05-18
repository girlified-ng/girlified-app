package com.girlified.girlified

import android.accessibilityservice.AccessibilityService
import android.accessibilityservice.AccessibilityServiceInfo
import android.content.Intent
import android.graphics.Color
import android.graphics.PixelFormat
import android.util.Log
import android.view.Gravity
import android.view.WindowManager
import android.view.accessibility.AccessibilityEvent
import android.view.accessibility.AccessibilityNodeInfo
import android.widget.TextView

class AntiViolenceAccessibilityService : AccessibilityService() {
    private var windowManager: WindowManager? = null
    private var overlayView: TextView? = null
    private var isOverlayShowing = false

    private val targetPackages = setOf("com.instagram.android", "com.twitter.android", "com.android.settings")
    // These would typically sync via MethodChannel to SharedPreferences
    private val keywords = listOf(
        // Traditional insults & Cyberbullying
        "bullying", "harassment", "ugly", "fat", "loser", "worthless",
        "cancel", "cancelled", "dox", "doxxed", "caught in 4k",
        "dirl", "gcad", "idttu", // die in real life, get cancer and die, i dont talk to you
        
        // Self-harm & Mental Health slang (Algospeak)
        "kys", "kill yourself", "kms", "kill myself", "sh", "lms", 
        "unalive", "sewer slide", "menty b", "stressy depressy", 
        "grippy sock vacation", "blithe", "i had pasta tonight", "cutfor",
        
        // Eating disorder slang
        "ana", "mia", "thinspo", "proana",
        
        // Explicit content & Grooming tactics
        "porn", "nsfw", "sex", "nudes", "onlyfans", "camgirl",
        "gnoc", "np4np", "our x", "iw2mu", "mmas", "mos", "cd9"
    )

    override fun onServiceConnected() {
        super.onServiceConnected()
        val info = AccessibilityServiceInfo()
        info.eventTypes = AccessibilityEvent.TYPE_WINDOW_CONTENT_CHANGED or AccessibilityEvent.TYPE_VIEW_TEXT_CHANGED or AccessibilityEvent.TYPE_WINDOW_STATE_CHANGED
        info.packageNames = targetPackages.toTypedArray()
        info.feedbackType = AccessibilityServiceInfo.FEEDBACK_GENERIC
        info.flags = AccessibilityServiceInfo.FLAG_REPORT_VIEW_IDS or AccessibilityServiceInfo.FLAG_RETRIEVE_INTERACTIVE_WINDOWS
        serviceInfo = info
        
        windowManager = getSystemService(WINDOW_SERVICE) as WindowManager
        Log.d("SaifeGuardianA11y", "Service connected")
    }

    override fun onAccessibilityEvent(event: AccessibilityEvent) {
        val rootNode = rootInActiveWindow ?: return
        val packageName = event.packageName?.toString() ?: return
        
        // Settings Monitor: Intercept uninstall or service disable
        if (packageName == "com.android.settings") {
            if (traverseForAppInfo(rootNode)) {
                showSettingsPinOverlay()
            } else if (isOverlayShowing) {
                hideOverlay()
            }
            return
        }

        // Harassment Monitor
        if (targetPackages.contains(packageName)) {
            val found = traverseAndCheckKeywords(rootNode)
            if (found && !isOverlayShowing) {
                showOverlay("Safe Space Enforced: Harassment Filter Active")
            } else if (!found && isOverlayShowing) {
                hideOverlay()
            }
        }
    }
    
    private fun traverseForAppInfo(node: AccessibilityNodeInfo): Boolean {
        if (node.text != null) {
            val text = node.text.toString().lowercase()
            if (text.contains("girlified") || text.contains("saifeai guardian")) {
                return true
            }
        }
        for (i in 0 until node.childCount) {
            val child = node.getChild(i)
            if (child != null) {
                if (traverseForAppInfo(child)) {
                    return true
                }
            }
        }
        return false
    }

    private fun traverseAndCheckKeywords(node: AccessibilityNodeInfo): Boolean {
        if (node.text != null) {
            val text = node.text.toString().lowercase()
            for (keyword in keywords) {
                if (text.contains(keyword)) {
                    return true
                }
            }
        }
        for (i in 0 until node.childCount) {
            val child = node.getChild(i)
            if (child != null) {
                if (traverseAndCheckKeywords(child)) {
                    return true
                }
            }
        }
        return false
    }

    private fun showSettingsPinOverlay() {
        showOverlay("Protected Action: Open Girlified to disable protections.")
    }

    private fun showOverlay(message: String) {
        if (overlayView == null) {
            overlayView = TextView(this).apply {
                setTextColor(Color.WHITE)
                setBackgroundColor(Color.parseColor("#E6000000")) // 90% opaque black
                gravity = Gravity.CENTER
                textSize = 24f
                setPadding(32, 32, 32, 32)
            }
        }
        overlayView?.text = message

        val params = WindowManager.LayoutParams(
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.MATCH_PARENT,
            WindowManager.LayoutParams.TYPE_ACCESSIBILITY_OVERLAY,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or WindowManager.LayoutParams.FLAG_NOT_TOUCHABLE,
            PixelFormat.TRANSLUCENT
        )

        try {
            if (!isOverlayShowing) {
                windowManager?.addView(overlayView, params)
                isOverlayShowing = true
            } else {
                windowManager?.updateViewLayout(overlayView, params)
            }
        } catch (e: Exception) {
            Log.e("SaifeGuardianA11y", "Error showing overlay", e)
        }
    }

    private fun hideOverlay() {
        try {
            if (isOverlayShowing) {
                windowManager?.removeView(overlayView)
                isOverlayShowing = false
            }
        } catch (e: Exception) {
            Log.e("SaifeGuardianA11y", "Error hiding overlay", e)
        }
    }

    override fun onInterrupt() {
        hideOverlay()
    }
}
