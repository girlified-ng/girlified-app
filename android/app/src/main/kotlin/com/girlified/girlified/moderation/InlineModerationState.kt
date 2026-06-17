package com.girlified.girlified.moderation

import android.graphics.Rect

/** Per-post reveal state — isolated so revealing one post does not affect others. */
object InlineModerationState {
    private val revealedKeys = mutableSetOf<String>()

    fun isRevealed(key: String): Boolean = key in revealedKeys

    fun reveal(key: String) {
        revealedKeys.add(key)
    }

    fun clearRevealed() {
        revealedKeys.clear()
    }

    fun buildPostKey(packageName: String, bounds: Rect, text: String): String {
        val normalized = text.trim().lowercase()
        return "$packageName:${bounds.left},${bounds.top},${bounds.right},${bounds.bottom}:$normalized"
    }
}
