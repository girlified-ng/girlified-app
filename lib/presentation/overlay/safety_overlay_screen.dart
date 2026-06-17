import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class SafetyOverlayScreen extends StatelessWidget {
  const SafetyOverlayScreen({super.key});

  Future<void> _returnToSaifeAi() async {
    await FlutterOverlayWindow.shareData({'action': 'return_to_saife'});
    await FlutterOverlayWindow.closeOverlay();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) {
        if (!didPop) {
          _returnToSaifeAi();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                child: Container(
                  color: const Color(0x9C1A1625),
                ),
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D2640),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: const Color(0xFF8B5CF6),
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
                      'SaifeAI has intercepted threatening or harmful content. '
                      'Tap below to return to SaifeAI.',
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
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _returnToSaifeAi,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B5CF6),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Return to SaifeAI',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
