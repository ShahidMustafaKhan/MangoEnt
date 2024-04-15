package com.livestream.mangoEnt

import android.content.Context
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.googlemobileads.GoogleMobileAdsPlugin

class MainActivity : FlutterFragmentActivity() {
    private val CHANNEL = "com.livestream.mangoEnt/context_channel"
    private var flutterContext: Context? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        // Set up the method channel to receive context from Flutter
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "passContext") {
                    val context = call.argument<Context>("context")
                    if (context != null) {
                        flutterContext = context
                        registerNativeAdFactories(flutterEngine)
                        result.success(true)
                    } else {
                        result.error("CONTEXT_ERROR", "Failed to receive context from Flutter.", null)
                    }
                } else {
                    result.notImplemented()
                }
            }
    }

    private fun registerNativeAdFactories(flutterEngine: FlutterEngine) {
        // Register the ListTileNativeAdFactory using the received context
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "listTile", ListTileNativeAdFactory(flutterContext!!)
        )

        // Register the GridTileNativeAdFactory using the received context
        GoogleMobileAdsPlugin.registerNativeAdFactory(
            flutterEngine, "gridTile", GridTileNativeAdFactory(flutterContext!!)
        )
    }
}
