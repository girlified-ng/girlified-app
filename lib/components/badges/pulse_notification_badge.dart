import 'package:flutter/material.dart';

class PulseNotificationBadge extends StatefulWidget {
  final Color color;
  final double size;

  const PulseNotificationBadge({
    Key? key,
    this.color = Colors.red,
    this.size = 5.0,
  }) : super(key: key);

  @override
  State<PulseNotificationBadge> createState() => _PulseNotificationBadgeState();
}

class _PulseNotificationBadgeState extends State<PulseNotificationBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.scale(
          scale: _animation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: widget.color,
            ),
          ),
        );
      },
    );
  }
}
