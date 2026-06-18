import 'package:flutter/material.dart';

/// Full-page warning preview for the SaifeAI protection debug panel.
class FullPageWarningContent extends StatelessWidget {
  const FullPageWarningContent({
    super.key,
    this.matchedKeyword,
    this.onContinue,
    this.onExitApp,
  });

  final String? matchedKeyword;
  final VoidCallback? onContinue;
  final VoidCallback? onExitApp;

  static const String warningTitle = 'Harmful Content Detected';
  static const String warningBody =
      'SaifeAI found language that may involve bullying or harassment on this screen. '
      'For your safety, we have paused this view. You can continue scrolling carefully '
      'or exit the app.';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF2D2640),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFF8B5CF6), width: 2),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.warning_amber_rounded,
            color: Color(0xFFDC2626),
            size: 72,
          ),
          const SizedBox(height: 20),
          const Text(
            warningTitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'SF Pro',
            ),
          ),
          const SizedBox(height: 10),
          Text(
            matchedKeyword != null && matchedKeyword!.isNotEmpty
                ? '$warningBody\n\nMatched term: "$matchedKeyword"'
                : warningBody,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xB3FFFFFF),
              fontSize: 14,
              height: 1.45,
              fontFamily: 'SF Pro',
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onContinue,
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
                'Continue',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF Pro',
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: onExitApp,
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF8B5CF6),
                side: const BorderSide(color: Color(0xFF8B5CF6), width: 2),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Exit App',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SF Pro',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
