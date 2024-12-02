import 'package:flutter/material.dart';

class AnimatedArrow extends StatefulWidget {
  const AnimatedArrow({super.key, this.isDown, this.animationDuration, required this.color});

  final bool? isDown;
  final Duration? animationDuration;
  final Color color;

  @override
  State<AnimatedArrow> createState() => _AnimatedArrowState();
}

class _AnimatedArrowState extends State<AnimatedArrow>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  static const Duration _animationDuration = Duration(milliseconds: 150);

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: _animationDuration);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedRotation(
      turns: widget.isDown != null
          ? widget.isDown!
              ? 0.5
              : 0.0
          : 0.0,
      duration: widget.animationDuration ?? _animationDuration,
      child: Icon(
        Icons.keyboard_arrow_down,
        color: widget.color,
      ),
    );
  }
}
