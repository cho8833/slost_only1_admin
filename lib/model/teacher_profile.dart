import 'package:json_annotation/json_annotation.dart';
import 'package:slost_only1_admin/enums/age.dart';
import 'package:slost_only1_admin/enums/dolbom_category.dart';
import 'package:slost_only1_admin/enums/gender.dart';
import 'package:slost_only1_admin/enums/teacher_profile_status.dart';

part 'teacher_profile.g.dart';

@JsonSerializable()
class TeacherProfile {
  int id;
  String? name;
  Gender? gender;
  String? profileImageUrl;
  DateTime? birthday;
  String? profileName;
  String? introduce;
  String? howBecameTeacher;

  TeacherProfile(
      this.id,
      this.name,
      this.gender,
      this.profileImageUrl,
      this.birthday,
      this.profileName,
      this.introduce,
      this.howBecameTeacher,);

  factory TeacherProfile.fromJson(Map<String, dynamic> json) => _$TeacherProfileFromJson(json);

}


@JsonSerializable()
class TeacherProfileDetail {
  int id;
  String? name;
  Gender? gender;
  String? profileImageUrl;
  DateTime? birthday;
  String? profileName;
  String? introduce;
  String? howBecameTeacher;
  TeacherProfileStatus status;
  List<Age>? availableAge;
  List<DolbomCategory>? availableCategory;

  TeacherProfileDetail(
      this.id,
      this.name,
      this.gender,
      this.profileImageUrl,
      this.birthday,
      this.profileName,
      this.introduce,
      this.status,
      this.howBecameTeacher,
      this.availableAge,
      this.availableCategory);

  factory TeacherProfileDetail.fromJson(Map<String, dynamic> json) => _$TeacherProfileDetailFromJson(json);
}