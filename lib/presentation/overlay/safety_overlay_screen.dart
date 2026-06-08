import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class SafetyOverlayScreen extends StatelessWidget {
  const SafetyOverlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Blurred glassmorphic background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                color: const Color(0x9C1A1625), // Semi-transparent dark mode background
              ),
            ),
          ),
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: const Color(0xFF2D2640), // Card background
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: const Color(0xFF8B5CF6), // Electric Lilac border
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B5CF6).withOpacity(0.4),
                    blurRadius: 24,
                    spreadRadius: 2,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF4D4D).withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.gpp_maybe_rounded,
                      color: Color(0xFFFF4D4D),
                      size: 56,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Harmful Content Blocked',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SF Pro',
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'SaifeAI has intercepted threatening or harmful content on your screen. Tap below to dismiss or reveal.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontFamily: 'SF Pro',
                      height: 1.5,
                      decoration: TextDecoration.none,
                    ),
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () async {
                            await FlutterOverlayWindow.closeOverlay();
                          },
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: Colors.white24),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Scroll Away',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () async {
                            await FlutterOverlayWindow.closeOverlay();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF8B5CF6), // Electric lilac
                            foregroundColor: Colors.white,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            'Reveal Content',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              fontFamily: 'SF Pro',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
