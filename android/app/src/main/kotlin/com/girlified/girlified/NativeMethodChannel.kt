package com.girlified.girlified

import android.content.BroadcastReceiver
import android.content.IntentFilter
import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Handler
import android.os.Looper
import android.util.Log
import android.provider.Settings
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodChannel

class NativeMethodChannel(
    private val context: Context,
    flutterEngine: FlutterEngine
) {
    private val methodChannel = MethodChannel(
        flutterEngine.dartExecutor.binaryMessenger,
        "com.girlified.saife/native"
    )
    
    private val eventChannel = EventChannel(
        flutterEngine.dartExecutor.binaryMessenger,
        "com.girlified.saife/events"
    )
    
    private var eventSink: EventChannel.EventSink? = null
    private var receiver: BroadcastReceiver? = null
    private val mainHandler = Handler(Looper.getMainLooper())

    companion object {
        private const val TAG = "SAFETY_APP_DETECT"
    }

    init {
        setupMethodChannel()
        setupEventChannel()
    }

    private fun setupMethodChannel() {
        methodChannel.setMethodCallHandler { call, result ->
            when (call.method) {
                "isAccessibilityServiceEnabled" -> {
                    val isEnabled = SaifeAccessibilityService.isServiceEnabled(context)
                    result.success(isEnabled)
                }
                
                "openAccessibilitySettings" -> {
                    openAccessibilitySettings()
                    result.success(null)
                }
                
                "canDrawOverlays" -> {
                    val canDraw = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                        Settings.canDrawOverlays(context)
                    } else {
                        true
                    }
                    result.success(canDraw)
                }
                
                "requestOverlayPermission" -> {
                    requestOverlayPermission()
                    result.success(null)
                }
                
                "startAccessibilityService" -> {
                    // Accessibility service is started by the system
                    // We can only guide users to enable it
                    result.success(null)
                }
                
                "stopAccessibilityService" -> {
                    // Send broadcast to stop service
                    result.success(null)
                }
                
                "setProtectionActive" -> {
                    val active = call.argument<Boolean>("active") ?: false
                    // Send broadcast to accessibility service
                    val intent = Intent("com.girlified.saife.SET_PROTECTION")
                    intent.putExtra("active", active)
                    context.sendBroadcast(intent)
                    result.success(null)
                }
                
                "updateSensitivity" -> {
                    val level = call.argument<Double>("level") ?: 2.0
                    // Send broadcast to accessibility service
                    val intent = Intent("com.girlified.saife.UPDATE_SENSITIVITY")
                    intent.putExtra("level", level)
                    context.sendBroadcast(intent)
                    result.success(null)
                }
                
                "getStatistics" -> {
                    // Get statistics from SharedPreferences
                    val prefs = context.getSharedPreferences("saife_stats", Context.MODE_PRIVATE)
                    val stats = mapOf(
                        "blockedCount" to prefs.getInt("blocked_count", 0),
                        "scanCount" to prefs.getInt("scan_count", 0)
                    )
                    result.success(stats)
                }
                
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun setupEventChannel() {
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                eventSink = events
                Log.d(TAG, "EventChannel listener attached — ready to forward scraped text")

                receiver = object : BroadcastReceiver() {
                    override fun onReceive(ctx: Context?, intent: Intent?) {
                        if (intent == null) return
                        val action = intent.action ?: return

                        when (action) {
                            "com.girlified.saife.CONTENT_BLOCKED" -> {
                                val event = intent.getStringExtra("event") ?: "content_blocked"
                                val appData = intent.getStringExtra("data") ?: ""
                                Log.d(TAG, "Broadcast received: CONTENT_BLOCKED app=$appData")
                                sendEvent(
                                    event,
                                    mapOf(
                                        "event" to event,
                                        "data" to appData,
                                        "timestamp" to intent.getLongExtra("timestamp", 0L),
                                    ),
                                )
                            }
                            "com.girlified.saife.TEXT_SCRAPED" -> {
                                val texts = intent.getStringArrayListExtra("texts") ?: arrayListOf()
                                val pkg = intent.getStringExtra("package") ?: ""
                                Log.d(TAG, "Broadcast received: TEXT_SCRAPED count=${texts.size} package=$pkg")
                                texts.forEachIndexed { index, text ->
                                    Log.d(TAG, "Forwarding scraped[$index]: $text")
                                }
                                sendEvent(
                                    "text_scraped",
                                    mapOf(
                                        "event" to "text_scraped",
                                        "texts" to texts,
                                        "package" to pkg,
                                        "timestamp" to intent.getLongExtra("timestamp", 0L),
                                    ),
                                )
                            }
                            "com.girlified.saife.THREAT_DETECTED" -> {
                                val pkg = intent.getStringExtra("package") ?: ""
                                val keyword = intent.getStringExtra("keyword") ?: ""
                                Log.d(TAG, "Broadcast received: THREAT_DETECTED keyword=$keyword package=$pkg")
                                sendEvent(
                                    "threat_detected",
                                    mapOf(
                                        "event" to "threat_detected",
                                        "package" to pkg,
                                        "keyword" to keyword,
                                        "timestamp" to intent.getLongExtra("timestamp", 0L),
                                    ),
                                )
                            }
                        }
                    }
                }
                val filter = IntentFilter().apply {
                    addAction("com.girlified.saife.CONTENT_BLOCKED")
                    addAction("com.girlified.saife.TEXT_SCRAPED")
                    addAction("com.girlified.saife.THREAT_DETECTED")
                }
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    context.registerReceiver(receiver, filter, Context.RECEIVER_NOT_EXPORTED)
                } else {
                    context.registerReceiver(receiver, filter)
                }
            }

            override fun onCancel(arguments: Any?) {
                Log.d(TAG, "EventChannel listener cancelled")
                eventSink = null
                try {
                    receiver?.let { context.unregisterReceiver(it) }
                } catch (e: Exception) {
                    // Ignore
                }
                receiver = null
            }
        })
    }

    private fun openAccessibilitySettings() {
        val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
        intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        context.startActivity(intent)
    }

    private fun requestOverlayPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val intent = Intent(
                Settings.ACTION_MANAGE_OVERLAY_PERMISSION,
                Uri.parse("package:${context.packageName}")
            )
            intent.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
            context.startActivity(intent)
        }
    }

    fun sendEvent(event: String, data: Map<String, Any>) {
        val sink = eventSink
        if (sink == null) {
            Log.w(TAG, "EventSink is null — dropping event '$event' (Flutter not listening)")
            return
        }

        val eventData = mutableMapOf<String, Any>("event" to event)
        eventData.putAll(data)

        mainHandler.post {
            try {
                sink.success(eventData)
                Log.d(TAG, "EventChannel delivered: $event")
            } catch (e: Exception) {
                Log.e(TAG, "EventChannel delivery failed for '$event'", e)
            }
        }
    }
}



