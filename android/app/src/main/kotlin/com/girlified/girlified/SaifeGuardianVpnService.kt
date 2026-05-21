package com.girlified.girlified

import android.content.Intent
import android.net.VpnService
import android.os.ParcelFileDescriptor
import android.util.Log
import java.io.FileInputStream
import java.io.FileOutputStream
import java.net.DatagramPacket
import java.net.DatagramSocket
import java.net.InetAddress
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
            builder.addRoute("192.0.2.111", 32) // Route ONLY DNS server traffic to VPN interface
            builder.addDnsServer("192.0.2.111")
            
            vpnInterface = builder.setSession("SaifeAI Guardian").establish()
            isRunning = true
            
            Log.d("SaifeGuardianVpn", "VPN Interface established (DNS-only)")
            
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
                while (isRunning) {
                    val length = input.read(buffer.array())
                    if (length > 0) {
                        val packet = buffer.array().sliceArray(0 until length)
                        
                        // Check if it's IPv4
                        val version = (packet[0].toInt() ushr 4) and 0x0F
                        if (version == 4) {
                            val protocol = packet[9].toInt()
                            if (protocol == 17) { // UDP
                                val ihl = (packet[0].toInt() and 0x0F) * 4
                                
                                val srcPort = ((packet[ihl].toInt() and 0xFF) shl 8) or (packet[ihl + 1].toInt() and 0xFF)
                                val destPort = ((packet[ihl + 2].toInt() and 0xFF) shl 8) or (packet[ihl + 3].toInt() and 0xFF)
                                
                                if (destPort == 53) {
                                    val udpLen = ((packet[ihl + 4].toInt() and 0xFF) shl 8) or (packet[ihl + 5].toInt() and 0xFF)
                                    val dnsPayloadLength = udpLen - 8
                                    
                                    if (dnsPayloadLength > 0 && ihl + 8 + dnsPayloadLength <= length) {
                                        val dnsPayload = packet.sliceArray(ihl + 8 until ihl + 8 + dnsPayloadLength)
                                        
                                        // Forward DNS query upstream in a background thread to handle concurrent queries
                                        thread {
                                            try {
                                                val dnsServer = InetAddress.getByName("1.1.1.3") // Cloudflare Family DNS (blocks malware & adult content)
                                                val queryPacket = DatagramPacket(dnsPayload, dnsPayload.size, dnsServer, 53)
                                                
                                                val socket = DatagramSocket()
                                                protect(socket)
                                                socket.soTimeout = 2000
                                                socket.send(queryPacket)
                                                
                                                val recvBuf = ByteArray(4096)
                                                val recvPacket = DatagramPacket(recvBuf, recvBuf.size)
                                                socket.receive(recvPacket)
                                                
                                                val responsePayload = recvPacket.data.sliceArray(0 until recvPacket.length)
                                                
                                                // Construct IP/UDP response
                                                val srcIp = packet.sliceArray(16..19) // Original Destination IP (our DNS IP 192.0.2.111)
                                                val destIp = packet.sliceArray(12..15) // Original Source IP (device client)
                                                
                                                val responsePacketBytes = buildIpUdpPacket(
                                                    srcIp, destIp,
                                                    53, srcPort,
                                                    responsePayload
                                                )
                                                
                                                synchronized(output) {
                                                    output.write(responsePacketBytes)
                                                }
                                                socket.close()
                                            } catch (e: Exception) {
                                                Log.e("SaifeGuardianVpn", "Error handling DNS query", e)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        buffer.clear()
                    }
                }
            } catch (e: Exception) {
                if (isRunning) {
                    Log.e("SaifeGuardianVpn", "Error in packet loop", e)
                }
            }
        }
    }

    private fun buildIpUdpPacket(srcIp: ByteArray, destIp: ByteArray, srcPort: Int, destPort: Int, payload: ByteArray): ByteArray {
        val ipHeaderLen = 20
        val udpHeaderLen = 8
        val totalLen = ipHeaderLen + udpHeaderLen + payload.size
        val packet = ByteArray(totalLen)
        
        // IP Header
        packet[0] = 0x45.toByte() // Version = 4, IHL = 5 (20 bytes)
        packet[1] = 0.toByte()    // TOS
        packet[2] = (totalLen ushr 8).toByte()
        packet[3] = (totalLen and 0xFF).toByte()
        packet[4] = 0.toByte()
        packet[5] = 0.toByte()
        packet[6] = 0.toByte()
        packet[7] = 0.toByte()
        packet[8] = 64.toByte() // TTL = 64
        packet[9] = 17.toByte() // Protocol = UDP (17)
        
        System.arraycopy(srcIp, 0, packet, 12, 4)
        System.arraycopy(destIp, 0, packet, 16, 4)
        
        // Calculate IP Checksum
        val checksum = calculateChecksum(packet, 0, ipHeaderLen)
        packet[10] = (checksum ushr 8).toByte()
        packet[11] = (checksum and 0xFF).toByte()
        
        // UDP Header
        packet[20] = (srcPort ushr 8).toByte()
        packet[21] = (srcPort and 0xFF).toByte()
        packet[22] = (destPort ushr 8).toByte()
        packet[23] = (destPort and 0xFF).toByte()
        val udpLen = udpHeaderLen + payload.size
        packet[24] = (udpLen ushr 8).toByte()
        packet[25] = (udpLen and 0xFF).toByte()
        packet[26] = 0.toByte() // UDP checksum (0 means ignored/not computed)
        packet[27] = 0.toByte()
        
        System.arraycopy(payload, 0, packet, 28, payload.size)
        
        return packet
    }

    private fun calculateChecksum(buf: ByteArray, offset: Int, length: Int): Int {
        var sum = 0
        var i = offset
        val limit = offset + length
        while (i < limit - 1) {
            sum += ((buf[i].toInt() and 0xFF) shl 8) or (buf[i + 1].toInt() and 0xFF)
            i += 2
        }
        if (i < limit) {
            sum += (buf[i].toInt() and 0xFF) shl 8
        }
        while (sum ushr 16 != 0) {
            sum = (sum and 0xFFFF) + (sum ushr 16)
        }
        return (sum.inv()) and 0xFFFF
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
