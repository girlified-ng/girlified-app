package com.girlified.girlified.moderation

import android.graphics.Rect

/** Snapshot of a single flagged text node on screen. */
data class FlaggedContent(
    val key: String,
    val bounds: Rect,
    val matchedKeyword: String,
)
