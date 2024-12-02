import 'package:flutter/material.dart';

class HeightAnimationBox extends StatefulWidget {
  const HeightAnimationBox(
      {super.key,
      this.duration = const Duration(milliseconds: 150),
      required this.show,
      required this.child});

  final bool show;
  final Widget child;
  final Duration duration;

  @override
  State<HeightAnimationBox> createState() => _HeightAnimationBoxState();
}

class _HeightAnimationBoxState extends State<HeightAnimationBox> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration:
          widget.duration,
      child: SizedBox(height: widget.show ? null : 0.0, child: widget.child),
    );
  }
}
