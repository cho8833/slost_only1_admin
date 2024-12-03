import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1_admin/model/teacher_profile.dart';
import 'package:slost_only1_admin/provider/teacher_provider.dart';
import 'package:slost_only1_admin/support/server_response.dart';
import 'package:slost_only1_admin/widget/button_base.dart';
import 'package:slost_only1_admin/widget/profile_image_circle.dart';

class ManageTeacherScreen extends StatefulWidget {
  const ManageTeacherScreen({super.key});

  @override
  State<ManageTeacherScreen> createState() => _ManageTeacherScreenState();
}

class _ManageTeacherScreenState extends State<ManageTeacherScreen> {
  late TeacherProvider teacherProvider;

  int page = 0;

  static const double _profileImageWidth = 150;
  static const double _columnWidth = 200;

  @override
  void initState() {
    super.initState();
    teacherProvider = context.read<TeacherProvider>();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          children: [
            SizedBox(
              width: _profileImageWidth,
              child: Text("프로필 이미지"),
            ),
            SizedBox(
              width: _columnWidth + 16,
              child: Text("이름"),
            ),
            SizedBox(
              width: _columnWidth + 16,
              child: Text("성별"),
            ),
            SizedBox(
              width: _columnWidth + 16,
              child: Text("자기소개"),
            )
          ],
        ),
        const SizedBox(height: 16,),
        FutureBuilder(
            future: teacherProvider.list(page),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                PagedData<TeacherProfile> data = snapshot.data!;
                if (data.numberOfElements == 0) {
                  return const Center(
                    child: Text("등록된 선생님이 없습니다"),
                  );
                }
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.numberOfElements,
                    itemBuilder: (context, index) {
                      TeacherProfile teacherProfile = data.content[index];
                      return ButtonBase(
                        onTap: () {
                          context.go("/teacher/${teacherProfile.id}");
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(
                              width: _profileImageWidth,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ProfileImageCircle(
                                      imageUrl: teacherProfile.profileImageUrl),
                                ],
                              ),
                            ),
                            ColumnBox(child: Text(teacherProfile.name ?? "-")),
                            ColumnBox(
                                child:
                                    Text(teacherProfile.gender?.title ?? "-")),
                            ColumnBox(
                                child: Text(teacherProfile.introduce ?? "-"))
                          ],
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Container();
              }
            }),
        const SizedBox(height: 32,),

      ],
    );
  }
}

class ColumnBox extends StatelessWidget {
  const ColumnBox({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 16),
      width: _ManageTeacherScreenState._columnWidth,
      child: child,
    );
  }
}
