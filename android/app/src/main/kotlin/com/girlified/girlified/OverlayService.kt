package com.girlified.girlified

import android.accessibilityservice.AccessibilityService
import android.content.Context
import android.graphics.Color
import android.graphics.PixelFormat
import android.os.Build
import android.util.Log
import android.view.Gravity
import android.view.LayoutInflater
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.ImageView
import android.widget.RelativeLayout
import android.widget.TextView

class OverlayService(private val context: Context) {

    private val TAG = "OverlayService"
    private var windowManager: WindowManager? = null
    private var overlayView: View? = null
    private var isOverlayShowing = false

    init {
        windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
    }

    fun showOverlay(sourceApp: String) {
        if (isOverlayShowing) return

        try {
            val layoutType = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                WindowManager.LayoutParams.TYPE_APPLICATION_OVERLAY
            } else {
                @Suppress("DEPRECATION")
                WindowManager.LayoutParams.TYPE_SYSTEM_ALERT
            }

            val params = WindowManager.LayoutParams(
                WindowManager.LayoutParams.MATCH_PARENT,
                WindowManager.LayoutParams.MATCH_PARENT,
                layoutType,
                WindowManager.LayoutParams.FLAG_NOT_FOCUSABLE or
                        WindowManager.LayoutParams.FLAG_LAYOUT_IN_SCREEN or
                        WindowManager.LayoutParams.FLAG_BLUR_BEHIND,
                PixelFormat.TRANSLUCENT
            )

            params.gravity = Gravity.CENTER

            // Create overlay view
            overlayView = createOverlayView(sourceApp)

            windowManager?.addView(overlayView, params)
            isOverlayShowing = true

            Log.d(TAG, "Overlay shown for $sourceApp")
        } catch (e: Exception) {
            Log.e(TAG, "Error showing overlay", e)
        }
    }

    private fun createOverlayView(sourceApp: String): View {
        val layout = RelativeLayout(context).apply {
            setBackgroundColor(Color.parseColor("#E6000000")) // Semi-transparent black
        }

        // Create blur effect view
        val blurView = View(context).apply {
            setBackgroundColor(Color.parseColor("#CC1A1625")) // Dark with transparency
        }

        val blurParams = RelativeLayout.LayoutParams(
            RelativeLayout.LayoutParams.MATCH_PARENT,
            RelativeLayout.LayoutParams.MATCH_PARENT
        )
        layout.addView(blurView, blurParams)

        // Create content container
        val contentContainer = RelativeLayout(context).apply {
            id = View.generateViewId()
        }

        val containerParams = RelativeLayout.LayoutParams(
            RelativeLayout.LayoutParams.WRAP_CONTENT,
            RelativeLayout.LayoutParams.WRAP_CONTENT
        ).apply {
            addRule(RelativeLayout.CENTER_IN_PARENT)
        }
        layout.addView(contentContainer, containerParams)

        // Shield Icon (simplified - use drawable in production)
        val shieldIcon = ImageView(context).apply {
            id = View.generateViewId()
            setImageResource(android.R.drawable.ic_secure) // Placeholder
            val iconSize = (80 * context.resources.displayMetrics.density).toInt()
            layoutParams = RelativeLayout.LayoutParams(iconSize, iconSize).apply {
                addRule(RelativeLayout.CENTER_HORIZONTAL)
            }
        }
        contentContainer.addView(shieldIcon)

        // Warning Text
        val warningText = TextView(context).apply {
            id = View.generateViewId()
            text = "⚠️ Harmful Content Detected"
            textSize = 20f
            setTextColor(Color.WHITE)
            gravity = Gravity.CENTER
            layoutParams = RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.WRAP_CONTENT,
                RelativeLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                addRule(RelativeLayout.BELOW, shieldIcon.id)
                addRule(RelativeLayout.CENTER_HORIZONTAL)
                topMargin = (20 * context.resources.displayMetrics.density).toInt()
            }
        }
        contentContainer.addView(warningText)

        // Description Text
        val descriptionText = TextView(context).apply {
            id = View.generateViewId()
            text = "Girlified has detected potentially harmful content.\nWould you like to proceed?"
            textSize = 14f
            setTextColor(Color.parseColor("#B5B5B6"))
            gravity = Gravity.CENTER
            layoutParams = RelativeLayout.LayoutParams(
                (300 * context.resources.displayMetrics.density).toInt(),
                RelativeLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                addRule(RelativeLayout.BELOW, warningText.id)
                addRule(RelativeLayout.CENTER_HORIZONTAL)
                topMargin = (12 * context.resources.displayMetrics.density).toInt()
            }
        }
        contentContainer.addView(descriptionText)

        // Button Container
        val buttonContainer = RelativeLayout(context).apply {
            id = View.generateViewId()
            layoutParams = RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.WRAP_CONTENT,
                RelativeLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                addRule(RelativeLayout.BELOW, descriptionText.id)
                addRule(RelativeLayout.CENTER_HORIZONTAL)
                topMargin = (32 * context.resources.displayMetrics.density).toInt()
            }
        }
        contentContainer.addView(buttonContainer)

        // Scroll Away Button
        val scrollAwayBtn = Button(context).apply {
            id = View.generateViewId()
            text = "Scroll Away"
            textSize = 16f
            setTextColor(Color.WHITE)
            setBackgroundColor(Color.parseColor("#8B5CF6")) // Electric Lilac
            setPadding(48, 32, 48, 32)
            setOnClickListener {
                hideOverlay()
                // Simulate back press to exit the harmful content
                val service = context as AccessibilityService
                service.performGlobalAction(AccessibilityService.GLOBAL_ACTION_BACK)
            }
        }

        val scrollBtnParams = RelativeLayout.LayoutParams(
            RelativeLayout.LayoutParams.WRAP_CONTENT,
            RelativeLayout.LayoutParams.WRAP_CONTENT
        ).apply {
            marginEnd = (8 * context.resources.displayMetrics.density).toInt()
        }
        buttonContainer.addView(scrollAwayBtn, scrollBtnParams)

        // Reveal Content Button
        val revealBtn = Button(context).apply {
            text = "Reveal Content"
            textSize = 16f
            setTextColor(Color.parseColor("#8B5CF6"))
            setBackgroundColor(Color.parseColor("#2D2640"))
            setPadding(48, 32, 48, 32)
            setOnClickListener {
                hideOverlay()
            }
            layoutParams = RelativeLayout.LayoutParams(
                RelativeLayout.LayoutParams.WRAP_CONTENT,
                RelativeLayout.LayoutParams.WRAP_CONTENT
            ).apply {
                addRule(RelativeLayout.END_OF, scrollAwayBtn.id)
                marginStart = (8 * context.resources.displayMetrics.density).toInt()
            }
        }
        buttonContainer.addView(revealBtn)

        return layout
    }

    fun hideOverlay() {
        try {
            if (isOverlayShowing && overlayView != null) {
                windowManager?.removeView(overlayView)
                overlayView = null
                isOverlayShowing = false
                Log.d(TAG, "Overlay hidden")
            }
        } catch (e: Exception) {
            Log.e(TAG, "Error hiding overlay", e)
        }
    }

    fun isShowing(): Boolean = isOverlayShowing
}



