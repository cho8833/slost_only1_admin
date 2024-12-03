import 'package:flutter/material.dart';
import 'package:slost_only1_admin/screen/common/header.dart';
import 'package:slost_only1_admin/screen/common/side_menu.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.child});

  static const double sideBarWidth = 250;

  static const double sidePadding = 20;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
        const EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, sidePadding),
        child: Column(
          children: [
            Header(),
            Expanded(
              child: Row(
                children: [
                  const SizedBox(
                    width: sideBarWidth,
                    child: SideMenu(),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(child: child),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}