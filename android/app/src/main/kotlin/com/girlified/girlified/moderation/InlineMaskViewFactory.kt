package com.girlified.girlified.moderation

import android.content.Context
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.GradientDrawable
import android.util.TypedValue
import android.view.Gravity
import android.view.View
import android.widget.LinearLayout
import android.widget.TextView

/** Builds the inline blur-and-reveal placeholder UI for a flagged post. */
object InlineMaskViewFactory {
    const val WARNING_MESSAGE = "This comment was hidden for potential bullying."
    const val REVEAL_LABEL = "Show anyway"

    fun createMaskView(
        context: Context,
        postKey: String,
        onReveal: (String) -> Unit,
    ): View {
        val container = LinearLayout(context).apply {
            orientation = LinearLayout.VERTICAL
            gravity = Gravity.CENTER_VERTICAL
            background = GradientDrawable().apply {
                setColor(Color.parseColor("#F3F0FF"))
                cornerRadius = dp(context, 10).toFloat()
                setStroke(dp(context, 1), Color.parseColor("#8B5CF6"))
            }
            setPadding(dp(context, 12), dp(context, 10), dp(context, 12), dp(context, 10))
        }

        val warning = TextView(context).apply {
            text = WARNING_MESSAGE
            setTextColor(Color.parseColor("#374151"))
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 13f)
            typeface = Typeface.create(Typeface.DEFAULT, Typeface.NORMAL)
        }

        val revealButton = TextView(context).apply {
            text = REVEAL_LABEL
            setTextColor(Color.parseColor("#7C3AED"))
            setTextSize(TypedValue.COMPLEX_UNIT_SP, 13f)
            typeface = Typeface.create(Typeface.DEFAULT, Typeface.BOLD)
            setPadding(0, dp(context, 6), 0, 0)
            setOnClickListener { onReveal(postKey) }
        }

        container.addView(warning)
        container.addView(revealButton)
        return container
    }

    private fun dp(context: Context, value: Int): Int {
        return TypedValue.applyDimension(
            TypedValue.COMPLEX_UNIT_DIP,
            value.toFloat(),
            context.resources.displayMetrics,
        ).toInt()
    }
}
