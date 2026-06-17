package com.girlified.girlified.moderation

import android.content.Context
import android.graphics.PixelFormat
import android.graphics.Rect
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import android.util.Log

/** Positions and syncs inline moderation masks over flagged accessibility nodes. */
class InlineOverlayManager(
    private val windowManager: WindowManager,
    private val context: Context,
) {
    private val overlayViews = mutableMapOf<String, View>()
    private val overlayParams = mutableMapOf<String, WindowManager.LayoutParams>()

    fun syncMasks(flaggedItems: List<FlaggedContent>) {
        val visibleKeys = flaggedItems.map { it.key }.toSet()

        overlayViews.keys.filter { it !in visibleKeys }.forEach { removeMask(it) }

        for (item in flaggedItems) {
            if (InlineModerationState.isRevealed(item.key)) {
                removeMask(item.key)
                continue
            }

            if (item.key in overlayViews) {
                updateMaskPosition(item)
            } else {
                addMask(item)
            }
        }
    }

    fun revealPost(postKey: String) {
        InlineModerationState.reveal(postKey)
        removeMask(postKey)
        Log.d(TAG, "Post revealed: $postKey")
    }

    fun clearAll() {
        overlayViews.keys.toList().forEach { removeMask(it) }
    }

    fun resetSession() {
        InlineModerationState.clearRevealed()
        clearAll()
    }

    private fun addMask(item: FlaggedContent) {
        val view = InlineMaskViewFactory.createMaskView(context, item.key) { key ->
            revealPost(key)
        }
        val params = buildLayoutParams(item.bounds)

        try {
            windowManager.addView(view, params)
            overlayViews[item.key] = view
            overlayParams[item.key] = params
        } catch (e: Exception) {
            Log.e(TAG, "Failed to add inline mask for ${item.key}", e)
        }
    }

    private fun updateMaskPosition(item: FlaggedContent) {
        val view = overlayViews[item.key] ?: return
        val params = overlayParams[item.key] ?: return
        applyBounds(params, item.bounds)
        try {
            windowManager.updateViewLayout(view, params)
        } catch (e: Exception) {
            Log.w(TAG, "Failed to reposition inline mask — re-adding", e)
            removeMask(item.key)
            addMask(item)
        }
    }

    private fun removeMask(key: String) {
        val view = overlayViews.remove(key) ?: return
        overlayParams.remove(key)
        try {
            windowManager.removeView(view)
        } catch (e: Exception) {
            Log.w(TAG, "Inline mask already removed: $key")
        }
    }

    private fun buildLayoutParams(bounds: Rect): WindowManager.LayoutParams {
        val params = WindowManager.LayoutParams(
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.WRAP_CONTENT,
            WindowManager.LayoutParams.TYPE_ACCESSIBILITY_OVERLAY,
            WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN or
                WindowManager.LayoutParams.FLAG_LAYOUT_NO_LIMITS,
            PixelFormat.TRANSLUCENT,
        )
        params.gravity = Gravity.TOP or Gravity.START
        applyBounds(params, bounds)
        return params
    }

    private fun applyBounds(params: WindowManager.LayoutParams, bounds: Rect) {
        val minHeight = dp(72)
        val minWidth = dp(120)
        params.x = bounds.left.coerceAtLeast(0)
        params.y = bounds.top.coerceAtLeast(0)
        params.width = bounds.width().coerceAtLeast(minWidth)
        params.height = bounds.height().coerceAtLeast(minHeight)
    }

    private fun dp(value: Int): Int {
        return TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP,
            value.toFloat(),
            context.resources.displayMetrics,
        ).toInt()
    }

    companion object {
        private const val TAG = "SAFETY_INLINE_MASK"
    }
}
