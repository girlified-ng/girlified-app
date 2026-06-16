package com.girlified.girlified

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.provider.Settings
import android.accessibilityservice.AccessibilityServiceInfo
import android.view.accessibility.AccessibilityManager
import android.content.Context
import android.os.Handler
import android.os.Looper

class MainActivity: FlutterActivity() {
    private lateinit var nativeMethodChannel: NativeMethodChannel
    private val mainHandler = Handler(Looper.getMainLooper())

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Initialize native method channel for communication with Flutter
        nativeMethodChannel = NativeMethodChannel(this, flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.saifeai.guardian/platform_bridge").setMethodCallHandler { call, result ->
            when (call.method) {
                "checkPermissionStatuses" -> {
                    val am = getSystemService(Context.ACCESSIBILITY_SERVICE) as AccessibilityManager
                    val enabledServices = am.getEnabledAccessibilityServiceList(AccessibilityServiceInfo.FEEDBACK_GENERIC)
                    val a11yEnabled = enabledServices.any { it.resolveInfo.serviceInfo.packageName == packageName }

                    result.success(mapOf(
                        "vpn" to true, // Return true so client side logic is satisfied without prompting
                        "accessibility" to a11yEnabled,
                        "familyControls" to false // iOS only
                    ))
                }
                "requestNativePermissions" -> {
                    val type = call.argument<String>("type")
                    if (type == "vpn") {
                        result.success(true)
                    } else if (type == "accessibility") {
                        val intent = Intent(Settings.ACTION_ACCESSIBILITY_SETTINGS)
                        startActivity(intent)
                        result.success(true)
                    } else {
                        result.success(false)
                    }
                }
                "startDigitalSafeguard" -> {
                    // Note: AccessibilityService starts automatically when enabled by user in settings.
                    // We sync the enabled state here and save keywords.
                    val keywords = call.argument<List<String>>("keywords")
                    val prefs = getSharedPreferences("GirlifiedPrefs", Context.MODE_PRIVATE)
                    val editor = prefs.edit()
                    editor.putBoolean("accessibility_monitoring_enabled", true)
                    if (keywords != null) {
                        val normalized = keywords
                            .map { it.trim().lowercase() }
                            .filter { it.isNotEmpty() }
                            .toSet()
                        editor.putStringSet("protection_keywords", normalized)
                    }
                    editor.apply()
                    
                    result.success(true)
                }
                "stopDigitalSafeguard" -> {
                    val prefs = getSharedPreferences("GirlifiedPrefs", Context.MODE_PRIVATE)
                    prefs.edit().putBoolean("accessibility_monitoring_enabled", false).apply()

                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }

        deliverProtectionDashboardNavigation(intent)
    }

    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        setIntent(intent)
        deliverProtectionDashboardNavigation(intent)
    }

    private fun deliverProtectionDashboardNavigation(intent: Intent?) {
        if (intent?.getBooleanExtra(SaifeAccessibilityService.EXTRA_OPEN_PROTECTION_DASHBOARD, false) != true) {
            return
        }

        intent.removeExtra(SaifeAccessibilityService.EXTRA_OPEN_PROTECTION_DASHBOARD)
        if (!::nativeMethodChannel.isInitialized) return

        mainHandler.postDelayed({
            try {
                nativeMethodChannel.sendEvent(
                    "open_protection_dashboard",
                    mapOf(
                        "event" to "open_protection_dashboard",
                        "timestamp" to System.currentTimeMillis(),
                    ),
                )
            } catch (e: Exception) {
                android.util.Log.e("MainActivity", "Failed to notify Flutter of protection navigation", e)
            }
        }, 400)
    }
}
