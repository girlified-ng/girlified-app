package com.girlified.girlified

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
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
            }

            override fun onCancel(arguments: Any?) {
                eventSink = null
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
        val eventData = mutableMapOf<String, Any>("event" to event)
        eventData.putAll(data)
        eventSink?.success(eventData)
    }
}



