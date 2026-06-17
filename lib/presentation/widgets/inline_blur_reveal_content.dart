import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:girlified/core/utilities/protection_keyword_store.dart';

/// Inline blur-and-reveal moderation for flagged text (in-app preview).
class InlineBlurRevealContent extends StatefulWidget {
  const InlineBlurRevealContent({
    super.key,
    required this.text,
    this.warningMessage = 'This comment was hidden for potential bullying.',
    this.revealLabel = 'Show anyway',
    this.matchedKeyword,
  });

  final String text;
  final String warningMessage;
  final String revealLabel;
  final String? matchedKeyword;

  @override
  State<InlineBlurRevealContent> createState() => _InlineBlurRevealContentState();
}

class _InlineBlurRevealContentState extends State<InlineBlurRevealContent> {
  bool _revealed = false;

  bool get _isFlagged {
    if (widget.matchedKeyword != null) return true;
    return ProtectionKeywordStore.findMatch(widget.text) != null;
  }

  @override
  Widget build(BuildContext context) {
    if (!_isFlagged || _revealed) {
      return Text(
        widget.text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          height: 1.45,
          fontFamily: 'SF Pro',
        ),
      );
    }

    return _MaskedPlaceholder(
      warningMessage: widget.warningMessage,
      revealLabel: widget.revealLabel,
      onReveal: () => setState(() => _revealed = true),
    );
  }
}

class _MaskedPlaceholder extends StatelessWidget {
  const _MaskedPlaceholder({
    required this.warningMessage,
    required this.revealLabel,
    required this.onReveal,
  });

  final String warningMessage;
  final String revealLabel;
  final VoidCallback onReveal;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xE8EEF2FF),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: const Color(0xFFC4B5FD)),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                child: Container(color: Colors.white.withOpacity(0.08)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    warningMessage,
                    style: const TextStyle(
                      color: Color(0xFF374151),
                      fontSize: 13,
                      height: 1.4,
                      fontFamily: 'SF Pro',
                    ),
                  ),
                  const SizedBox(height: 6),
                  GestureDetector(
                    onTap: onReveal,
                    child: Text(
                      revealLabel,
                      style: const TextStyle(
                        color: Color(0xFF7C3AED),
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'SF Pro',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
