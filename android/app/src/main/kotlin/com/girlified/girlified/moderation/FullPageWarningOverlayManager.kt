package com.girlified.girlified.moderation

import android.content.Context
import android.graphics.PixelFormat
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.WindowManager

/** Manages the full-screen warning overlay when harmful content is detected. */
class FullPageWarningOverlayManager(
    private val windowManager: WindowManager,
    private val context: Context,
    private val onContinue: () -> Unit,
    private val onExitApp: () -> Unit,
) {
    private var overlayView: View? = null

    val isShowing: Boolean get() = overlayView != null

    fun show(matchedKeyword: String, screenWidth: Int, screenHeight: Int): Boolean {
        if (overlayView != null) return false

        val view = FullPageWarningViewFactory.createOverlayView(
            context = context,
            matchedKeyword = matchedKeyword,
            onContinue = {
                dismiss()
                onContinue()
            },
            onExitApp = {
                dismiss()
                onExitApp()
            },
        )

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

        return try {
            windowManager.addView(view, params)
            overlayView = view
            Log.d(TAG, "Full-page warning overlay displayed")
            true
        } catch (e: Exception) {
            Log.e(TAG, "Failed to show full-page warning overlay", e)
            overlayView = null
            false
        }
    }

    fun dismiss() {
        overlayView?.let { view ->
            try {
                windowManager.removeView(view)
            } catch (e: Exception) {
                Log.w(TAG, "Full-page overlay already removed", e)
            }
        }
        overlayView = null
    }

    companion object {
        private const val TAG = "SAFETY_FULL_PAGE"
    }
}
