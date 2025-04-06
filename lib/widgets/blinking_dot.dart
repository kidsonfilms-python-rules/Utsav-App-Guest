import 'package:flutter/material.dart';

class BlinkingDot extends StatefulWidget {
  final Color color;
  final double size;
  final Animation<double>? animation; // Optional external animation

  const BlinkingDot({
    super.key,
    this.color = Colors.green,
    this.size = 8.0,
    this.animation,
  });

  @override
  State<BlinkingDot> createState() => _BlinkingDotState();
}

class _BlinkingDotState extends State<BlinkingDot>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation<double>? _internalAnimation;

  @override
  void initState() {
    super.initState();
    // Only create a controller if an external animation is not provided.
    if (widget.animation == null) {
      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 1),
      )..repeat(reverse: true);

      _internalAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller!);
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use the external animation if provided; otherwise, use the internal one.
    final animation = widget.animation ?? _internalAnimation!;
    return FadeTransition(
      opacity: animation,
      child: Container(
        width: widget.size,
        height: widget.size,
        decoration: BoxDecoration(
          color: widget.color,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
