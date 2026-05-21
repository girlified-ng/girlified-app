package com.girlified.girlified

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.content.Intent
import android.net.VpnService
import android.provider.Settings
import android.accessibilityservice.AccessibilityServiceInfo
import android.view.accessibility.AccessibilityManager
import android.content.Context

class MainActivity: FlutterActivity() {
    private lateinit var nativeMethodChannel: NativeMethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Initialize native method channel for communication with Flutter
        nativeMethodChannel = NativeMethodChannel(this, flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, "com.saifeai.guardian/platform_bridge").setMethodCallHandler { call, result ->
            when (call.method) {
                "checkPermissionStatuses" -> {
                    val vpnPrepared = VpnService.prepare(this) == null
                    val am = getSystemService(Context.ACCESSIBILITY_SERVICE) as AccessibilityManager
                    val enabledServices = am.getEnabledAccessibilityServiceList(AccessibilityServiceInfo.FEEDBACK_GENERIC)
                    val a11yEnabled = enabledServices.any { it.resolveInfo.serviceInfo.packageName == packageName }

                    result.success(mapOf(
                        "vpn" to vpnPrepared,
                        "accessibility" to a11yEnabled,
                        "familyControls" to false // iOS only
                    ))
                }
                "requestNativePermissions" -> {
                    val type = call.argument<String>("type")
                    if (type == "vpn") {
                        val intent = VpnService.prepare(this)
                        if (intent != null) {
                            startActivityForResult(intent, 0)
                        }
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
                    // Start VPN
                    val vpnIntent = Intent(this, SaifeGuardianVpnService::class.java)
                    startService(vpnIntent)
                    // Note: AccessibilityService starts automatically when enabled by user in settings.
                    // We sync the enabled state here.
                    val prefs = getSharedPreferences("GirlifiedPrefs", Context.MODE_PRIVATE)
                    prefs.edit().putBoolean("accessibility_monitoring_enabled", true).apply()
                    
                    result.success(true)
                }
                "stopDigitalSafeguard" -> {
                    val vpnIntent = Intent(this, SaifeGuardianVpnService::class.java)
                    stopService(vpnIntent)

                    val prefs = getSharedPreferences("GirlifiedPrefs", Context.MODE_PRIVATE)
                    prefs.edit().putBoolean("accessibility_monitoring_enabled", false).apply()

                    result.success(true)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }
}
