package com.example.bdix_vpn

import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.FlutterEngine
import android.net.TrafficStats

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.bdix_vpn/trafficStats"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getTrafficStats") {
                val trafficStats = getTrafficStats()
                result.success(trafficStats)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getTrafficStats(): Map<String, Int> {
        val stats = mutableMapOf<String, Int>()

        // Get total bytes sent and received as Long to prevent overflow
        val bytesSent = TrafficStats.getTotalTxBytes()
        val bytesReceived = TrafficStats.getTotalRxBytes()

        // Convert bytes to KB (divide by 1024)
        val kbSent = if (bytesSent < 0) 0 else (bytesSent / 1024).toInt()
        val kbReceived = if (bytesReceived < 0) 0 else (bytesReceived / 1024).toInt()

        // Return values in kilobytes (KB)
        stats["bytesSent"] = kbSent
        stats["bytesReceived"] = kbReceived

        return stats
    }
}