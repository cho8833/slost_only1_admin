import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ButtonBase extends StatelessWidget {
  const ButtonBase({super.key, required this.onTap, required this.child, this.onHover});

  final void Function() onTap;
  final Widget child;
  final void Function(PointerHoverEvent)? onHover;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: onHover,
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: child,
      ),
    );
  }
}

class ButtonTemplate extends StatelessWidget {
  const ButtonTemplate(
      {super.key,
      required this.title,
      required this.onTap,
      required this.isEnable,
      this.color});

  final String title;
  final void Function() onTap;
  final bool isEnable;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: ButtonBase(
        onTap: () {
          if (isEnable) {
            onTap();
          }
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isEnable ? color ?? Colors.blueAccent : Colors.black12),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
                color: isEnable ? Colors.white : Colors.grey,
                fontSize: 18,
                fontWeight: FontWeight.w700),
          ),
        ),
      ),
    );
  }
}
