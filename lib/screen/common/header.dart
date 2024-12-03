import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slost_only1_admin/model/member.dart';
import 'package:slost_only1_admin/provider/auth_provider.dart';
import 'package:slost_only1_admin/widget/button_base.dart';

class Header extends StatelessWidget {
  Header({super.key});

  static const double _iconSize = 30;

  final GlobalKey iconKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    Widget icon = Icon(
      key: iconKey,
      Icons.account_circle,
      size: _iconSize,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _homeButton(context),
          SizedBox(
            child: GestureDetector(
                onTap: () {
                  // icon 위치 바로 밑에 dialog 생성
                  Offset iconOffset =
                      (iconKey.currentContext!.findRenderObject() as RenderBox)
                          .localToGlobal(Offset.zero);
                  showUserDialog(context, iconOffset);
                },
                child: icon),
          )
        ],
      ),
    );
  }

  Widget _homeButton(BuildContext context) {
    return SizedBox(
        height: 30,
        child: ButtonBase(
            onTap: () => context.go("/main"), child: const Text("Home")));
  }

  void logout(BuildContext context) {
    AuthProvider().signOut().then((value) {
      context.go("/");
    });
  }

  void showUserDialog(BuildContext context, Offset position) {
    const double dialogWidth = 200;
    const double dialogHeight = 200;

    showDialog(
        anchorPoint: position,
        context: context,
        barrierDismissible: false,
        builder: (context) {
          AuthProvider authProvider = AuthProvider();
          Member user = authProvider.me!;
          TextTheme textTheme = Theme.of(context).textTheme;
          double screenWidth = MediaQuery.of(context).size.width;
          return Material(
            color: Colors.transparent,
            child: MaterialButton(
              mouseCursor: MouseCursor.defer,
              onPressed: () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              enableFeedback: false,
              child: Stack(
                children: [
                  Positioned(
                      left: screenWidth - dialogWidth - 8,
                      top: position.dy + _iconSize + 8,
                      child: SizedBox(
                        width: dialogWidth,
                        height: dialogHeight,
                        child: Container(
                          decoration: BoxDecoration(
                              color: Theme.of(context).cardColor,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "ACCOUNT",
                                      style: textTheme.titleSmall!.copyWith(
                                        fontSize: 10,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.account_circle,
                                          color: Colors.black,
                                          size: _iconSize,
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Expanded(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text("관리자"),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              const SizedBox(
                                height: 16,
                              ),
                              DialogButton(
                                textColor: Colors.red,
                                text: "Log Out",
                                onClick: () => logout(context),
                              )
                            ],
                          ),
                        ),
                      ))
                ],
              ),
            ),
          );
        });
  }
}

class DialogButton extends StatefulWidget {
  const DialogButton(
      {super.key,
      required this.textColor,
      required this.text,
      required this.onClick});

  final Color textColor;
  final String text;
  final void Function() onClick;

  @override
  State<DialogButton> createState() => _DialogButtonState();
}

class _DialogButtonState extends State<DialogButton> {
  Color backgroundColor = Colors.transparent;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onHover: (event) {
        setState(() {
          backgroundColor = const Color.fromRGBO(255, 255, 255, 0.1);
        });
      },
      onExit: (event) {
        setState(() {
          backgroundColor = Colors.transparent;
        });
      },
      child: GestureDetector(
        onTap: widget.onClick,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColor,
                ),
                padding: const EdgeInsets.fromLTRB(24, 16, 0, 16),
                child: Text(widget.text,
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: widget.textColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
