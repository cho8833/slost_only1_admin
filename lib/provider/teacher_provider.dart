import 'package:flutter/material.dart';
import 'package:slost_only1_admin/enums/teacher_profile_status.dart';
import 'package:slost_only1_admin/model/teacher_profile.dart';
import 'package:slost_only1_admin/repository/teacher_repository.dart';
import 'package:slost_only1_admin/support/server_response.dart';
import 'package:status_builder/status_builder.dart';

class TeacherProvider {
  TeacherProvider(this.repository);

  final TeacherRepository repository;

  ValueNotifier<Status> setStatusStatus = ValueNotifier(Status.idle);

  Future<PagedData<TeacherProfile>> list(int page) {
    return repository.fetchList(page);
  }

  Future<TeacherProfileDetail> getDetail(int id) {
    return repository.fetchDetail(id);
  }

  Future<void> setStatus(int id, TeacherProfileStatus status) async {
    setStatusStatus.value = Status.loading;
    await repository.setStatus(id, status).then((_) {
      setStatusStatus.value = Status.idle;
    }).catchError((e) {
      setStatusStatus.value = Status.idle;
      throw e;
    });
  }

}