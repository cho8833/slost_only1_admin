import 'package:slost_only1_admin/enums/teacher_profile_status.dart';
import 'package:slost_only1_admin/model/teacher_profile.dart';
import 'package:slost_only1_admin/support/server_response.dart';

abstract interface class TeacherRepository {
  Future<PagedData<TeacherProfile>> fetchList(int page);

  Future<TeacherProfileDetail> fetchDetail(int id);

  Future<void> setStatus(int id, TeacherProfileStatus status);
}