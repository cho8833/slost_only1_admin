import 'package:slost_only1_admin/model/teacher_profile.dart';
import 'package:slost_only1_admin/repository/teacher_repository.dart';
import 'package:slost_only1_admin/support/server_response.dart';

class TeacherProvider {
  TeacherProvider(this.repository);

  final TeacherRepository repository;

  Future<PagedData<TeacherProfile>> list(int page) {
    return repository.fetchList(page);
  }

  Future<TeacherProfileDetail> getDetail(int id) {
    return repository.fetchDetail(id);
  }

}