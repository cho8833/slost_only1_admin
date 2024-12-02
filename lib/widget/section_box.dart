import 'package:flutter/material.dart';

class SectionBox extends StatelessWidget {
  const SectionBox(
      {Key? key,
      required this.child,
      this.width,
      this.height})
      : super(key: key);

  final Widget child;

  final double? width;

  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: Theme.of(context).cardColor,
      ),
      child: child,
    );
  }
}
