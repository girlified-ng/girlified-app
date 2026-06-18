package com.girlified.girlified.moderation

import android.content.Context
import android.graphics.Color
import android.graphics.PixelFormat
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import android.widget.LinearLayout
import android.widget.TextView

/** Builds the full-screen SaifeAI warning block shown when harmful text is detected. */
object FullPageWarningViewFactory {
    const val WARNING_TITLE = "Harmful Content Detected"
    const val WARNING_BODY =
        "SaifeAI found language that may involve bullying or harassment on this screen. " +
            "For your safety, we have paused this view. You can continue scrolling carefully " +
            "or exit the app."
    const val CONTINUE_LABEL = "Continue"
    const val EXIT_APP_LABEL = "Exit App"

    fun createOverlayView(
        context: Context,
        matchedKeyword: String,
        onContinue: () -> Unit,
        onExitApp: () -> Unit,
    ): View {
        val screen = context.resources.displayMetrics
        val root = LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER
            setBackgroundColor(Color.parseColor("#E61A1625"))
            setPadding(dp(context, 24), dp(context, 24), dp(context, 24), dp(context, 24))
            layoutParams = LinearLayout.LayoutParams(screen.widthPixels, screen.heightPixels)
        }

        val card = LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER_HORIZONTAL
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#FF2D2640"))
                cornerRadius = dp(context, 20).toFloat()
                setStroke(dp(context, 2), Color.parseColor("#FF8B5CF6"))
            }
            setPadding(dp(context, 28), dp(context, 28), dp(context, 28), dp(context, 28))
        }

        val warningIcon = TextView(context).apply {
            text = "⚠"
            gravity = Gravity.CENTER
            setTextColor(Color.parseColor("#DC2626"))
            textSize = 64f
            setPadding(0, 0, 0, dp(context, 4))
        }

        val title = TextView(context).apply {
            text = WARNING_TITLE
            setTextColor(Color.WHITE)
            textSize = 20f
            typeface = Typeface.create(Typeface.DEFAULT, Typeface.BOLD)
            gravity = Gravity.CENTER
            setPadding(0, dp(context, 20), 0, dp(context, 8))
        }

        val body = TextView(context).apply {
            text = if (matchedKeyword.isNotEmpty()) {
                "$WARNING_BODY\n\nMatched term: \"$matchedKeyword\""
            } else {
                WARNING_BODY
            }
            setTextColor(Color.parseColor("#B3FFFFFF"))
            textSize = 14f
            gravity = Gravity.CENTER
            setLineSpacing(0f, 1.35f)
            setPadding(0, 0, 0, dp(context, 24))
        }

        val continueButton = TextView(context).apply {
            text = CONTINUE_LABEL
            setTextColor(Color.WHITE)
            textSize = 16f
            typeface = Typeface.create(Typeface.DEFAULT, Typeface.BOLD)
            gravity = Gravity.CENTER
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#FF8B5CF6"))
                cornerRadius = dp(context, 14).toFloat()
            }
            setPadding(dp(context, 24), dp(context, 16), dp(context, 24), dp(context, 16))
            setOnClickListener { onContinue() }
        }

        val exitButton = TextView(context).apply {
            text = EXIT_APP_LABEL
            setTextColor(Color.parseColor("#FF8B5CF6"))
            textSize = 15f
            typeface = Typeface.create(Typeface.DEFAULT, Typeface.BOLD)
            gravity = Gravity.CENTER
            background = GradientDrawable().apply {
                setColor(Color.TRANSPARENT)
                cornerRadius = dp(context, 14).toFloat()
                setStroke(dp(context, 2), Color.parseColor("#FF8B5CF6"))
            }
            setPadding(dp(context, 24), dp(context, 14), dp(context, 24), dp(context, 14))
            setOnClickListener { onExitApp() }
            val lp = LinearLayout.LayoutParams(
                LinearLayout.LayoutParams.MATCH_PARENT,
                LinearLayout.LayoutParams.WRAP_CONTENT,
            )
            lp.topMargin = dp(context, 12)
            layoutParams = lp
        }

        card.addView(warningIcon)
        card.addView(title)
        card.addView(body)
        card.addView(continueButton)
        card.addView(exitButton)
        root.addView(card)

        return root
    }

    private fun dp(context: Context, value: Int): Int {
        return TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP,
            value.toFloat(),
            context.resources.displayMetrics,
        ).toInt()
    }
}
