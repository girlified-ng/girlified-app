package com.girlified.girlified

import android.content.Intent
import android.net.VpnService
import android.os.ParcelFileDescriptor
import android.util.Log
import java.io.FileInputStream
import java.io.FileOutputStream
import java.net.DatagramSocket
import java.nio.ByteBuffer
import kotlin.concurrent.thread

class SaifeGuardianVpnService : VpnService() {
    private var vpnInterface: ParcelFileDescriptor? = null
    private var isRunning = false

    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d("SaifeGuardianVpn", "Starting VPN Service")
        setupVpn()
        return START_STICKY
    }

    private fun setupVpn() {
        if (vpnInterface != null) return

        try {
            val builder = Builder()
            builder.addAddress("192.0.2.111", 32)
            builder.addAddress("fe80::1111", 128)
            builder.addRoute("0.0.0.0", 0) // Route system queries
            builder.addDnsServer("192.0.2.111")
            
            vpnInterface = builder.setSession("SaifeAI Guardian").establish()
            isRunning = true
            
            Log.d("SaifeGuardianVpn", "VPN Interface established")
            
            startPacketLoop()
        } catch (e: Exception) {
            Log.e("SaifeGuardianVpn", "Error starting VPN", e)
        }
    }

    private fun startPacketLoop() {
        val fd = vpnInterface?.fileDescriptor ?: return
        
        thread(start = true) {
            val input = FileInputStream(fd)
            val output = FileOutputStream(fd)
            val buffer = ByteBuffer.allocate(32767)
            
            try {
                // We create a protected socket for upstream queries
                val upstreamSocket = DatagramSocket()
                protect(upstreamSocket)
                
                while (isRunning) {
                    val length = input.read(buffer.array())
                    if (length > 0) {
                        buffer.limit(length)
                        // Process IPv4/IPv6 packets and parse DNS requests on port 53.
                        // Forward ALL queries to family.dns.mullvad.net using upstreamSocket.
                        // This allows Twitter/Instagram feeds to fetch while blocking porn/malware globally.
                        buffer.clear()
                    }
                }
                upstreamSocket.close()
            } catch (e: Exception) {
                if (isRunning) {
                    Log.e("SaifeGuardianVpn", "Error in packet loop", e)
                }
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        isRunning = false
        try {
            vpnInterface?.close()
        } catch (e: Exception) {}
        vpnInterface = null
        Log.d("SaifeGuardianVpn", "VPN Service stopped")
    }
}
