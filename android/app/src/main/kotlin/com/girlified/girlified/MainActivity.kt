package com.girlified.girlified

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    private lateinit var nativeMethodChannel: NativeMethodChannel

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Initialize native method channel for communication with Flutter
        nativeMethodChannel = NativeMethodChannel(this, flutterEngine)
    }
}
