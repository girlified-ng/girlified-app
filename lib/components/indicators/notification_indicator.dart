import 'package:flutter/material.dart';

class NotificationIndicator extends StatefulWidget {
  const NotificationIndicator({super.key});

  @override
  State<NotificationIndicator> createState() => _NotificationIndicatorState();
}

class _NotificationIndicatorState extends State<NotificationIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    )..repeat();

    _colorAnimation = ColorTween(
      begin: Colors.red,
      end: Colors.red.shade200,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: _colorAnimation.value,
            borderRadius: BorderRadius.circular(100),
          ),
        );
      },
    );
  }
}
