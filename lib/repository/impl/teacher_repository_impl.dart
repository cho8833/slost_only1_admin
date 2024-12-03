import 'dart:io';

import 'package:http/http.dart';
import 'package:slost_only1_admin/model/teacher_profile.dart';
import 'package:slost_only1_admin/repository/teacher_repository.dart';
import 'package:slost_only1_admin/support/http_response_handler.dart';
import 'package:slost_only1_admin/support/server_response.dart';
import 'package:slost_only1_admin/support/server_uri.dart';

final class TeacherRepositoryImpl with ServerUri, HttpResponseHandler implements TeacherRepository {
  TeacherRepositoryImpl(this.interceptedClient);

  final Client interceptedClient;

  @override
  Future<PagedData<TeacherProfile>> fetchList(int page) async {
    Uri uri = getUri("/teacher", queryParameters: {
      "page": page.toString()
    });

    Response response = await interceptedClient.get(uri);

    return getPagedData(response, (p) => TeacherProfile.fromJson(p)).data;
  }

  @override
  Future<TeacherProfileDetail> fetchDetail(int id) async {
    Uri uri = getUri("/teacher/$id");

    Response response = await interceptedClient.get(uri);

    return getData(response, (p) => TeacherProfileDetail.fromJson(p)).data;
  }


}
