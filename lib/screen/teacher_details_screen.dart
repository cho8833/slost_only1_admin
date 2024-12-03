import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slost_only1_admin/model/teacher_profile.dart';
import 'package:slost_only1_admin/provider/teacher_provider.dart';
import 'package:slost_only1_admin/widget/profile_image_circle.dart';

class TeacherDetailsScreen extends StatefulWidget {
  const TeacherDetailsScreen({super.key, required this.id});

  final int id;

  @override
  State<TeacherDetailsScreen> createState() => _TeacherDetailsScreenState();
}

class _TeacherDetailsScreenState extends State<TeacherDetailsScreen> {
  late TeacherProvider teacherProvider;

  @override
  void initState() {
    super.initState();
    teacherProvider = context.read<TeacherProvider>();
  }

  // 일반 나이 계산
  static int calKoreanAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    return currentDate.year - birthDate.year + 1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: teacherProvider.getDetail(widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              TeacherProfileDetail data = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileImageCircle(imageUrl: data.profileImageUrl),
                  const SizedBox(height: 16,),
                  _Column(title: "이름", value: data.name ?? ""),
                  _Column(title: "성별", value: data.gender?.title ?? ""),
                  _Column(
                      title: "나이",
                      value: data.birthday != null
                          ? calKoreanAge(data.birthday!).toString()
                          : ""),
                  _Column(title: "프로필 이름", value: data.profileName ?? ""),
                  _Column(title: "자기소개", value: data.introduce ?? ""),
                  _Column(
                      title: "선생님이 된 계기",
                      value: data.howBecameTeacher ?? ""),
                  _Column(
                      title: "자신있는 연령",
                      value: data.availableAge
                              ?.map((age) => age.title)
                              .join(", ") ??
                          ""),
                  _Column(
                      title: "자신있는 수업",
                      value: data.availableCategory
                              ?.map((cat) => cat.title)
                              .join(", ") ??
                          "")
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          }
          return Container();
        });
  }
}

class _Column extends StatelessWidget {
  const _Column({required this.title, required this.value});

  final String title;

  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          SizedBox(
            width: 200,
              child: Text(title)),
          const SizedBox(
            width: 16,
          ),
          Text(value)
        ],
      ),
    );
  }
}
