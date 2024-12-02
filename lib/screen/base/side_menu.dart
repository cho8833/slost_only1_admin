import 'package:flutter/material.dart';
import 'package:slost_only1_admin/widget/animated_arrow.dart';
import 'package:slost_only1_admin/widget/height_animation_box.dart';
import 'package:slost_only1_admin/widget/section_box.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  static final Map<String, List<SectionContent Function(BuildContext)>>
      _sideBarAttributes = {
    "사용자 관리": [(context) => SectionContent(onPressed: () {}, title: "강사 관리")],
    "글 관리": [(context) => SectionContent(onPressed: () {}, title: "리뷰 관리")]
  };

  static const TextStyle _sectionTitleStyle = TextStyle(
      fontSize: 18, fontWeight: FontWeight.w600, color: sideMenuColor);

  static const Color sideMenuColor = Color.fromRGBO(128, 159, 184, 1);

  List<Section> _sections(BuildContext context) {
    List<Section> sections = [];
    _sideBarAttributes.forEach((key, value) {
      sections.add(Section(
          contents: value.map<SectionContent>((sectionContent) {
            return sectionContent(context);
          }).toList(),
          title: key));
    });
    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SectionBox(
        child: ListView(children: [
          // const SizedBox(height: 40,),
          // _homeButton(context),
          // const SizedBox(height: 56,),
          ..._sections(context),
        ]),
      ),
    );
  }
}

class Section extends StatefulWidget {
  const Section({Key? key, required this.contents, required this.title})
      : super(key: key);

  final List<SectionContent> contents;
  final String title;

  @override
  State<Section> createState() => _SectionState();
}

class _SectionState extends State<Section> {
  bool isOpen = false;
  static const Duration _animationDuration = Duration(milliseconds: 150);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            setState(() {
              isOpen = !isOpen;
            });
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: SideMenu._sectionTitleStyle,
                  ),
                  AnimatedArrow(
                    isDown: isOpen,
                    animationDuration: _animationDuration,
                    color: SideMenu.sideMenuColor,
                  )
                ],
              ),
              const SizedBox(
                height: 18,
              ),
              HeightAnimationBox(
                duration: _animationDuration,
                show: isOpen,
                child: ListView(
                  shrinkWrap: true,
                  children: widget.contents,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SectionContent extends StatelessWidget {
  const SectionContent(
      {super.key, required this.onPressed, required this.title});

  final void Function() onPressed;
  final String title;

  static const TextStyle titleStyle = TextStyle(
    color: SideMenu.sideMenuColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: SizedBox(
        height: 30,
        child: Row(
          children: [
            const VerticalDivider(
              thickness: 1,
              width: 1,
              color: Color.fromRGBO(200, 200, 203, 1),
            ),
            const SizedBox(width: 16),
            Flexible(
              child: Text(
                title,
                style: titleStyle,
              ),
            )
          ],
        ),
      ),
    );
  }
}
