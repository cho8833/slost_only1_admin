import 'dart:convert';

import 'package:http/http.dart';
import 'package:slost_only1_admin/data/authorization_token_res.dart';
import 'package:slost_only1_admin/data/sign_in_req.dart';
import 'package:slost_only1_admin/model/member.dart';
import 'package:slost_only1_admin/repository/auth_repository.dart';
import 'package:slost_only1_admin/support/http_response_handler.dart';
import 'package:slost_only1_admin/support/server_uri.dart';

final class AuthRepositoryImpl with ServerUri, HttpResponseHandler implements AuthRepository {
  AuthRepositoryImpl(this.client, this.interceptedClient);

  final Client interceptedClient;

  final Client client;

  @override
  Future<AuthorizationTokenRes> signIn(SignInReq req) async {
    Uri uri = getUri("/auth/sign-in/admin");

    Response response = await client.post(uri, body: jsonEncode(req.toJson()));

    return getData(response, (p) => AuthorizationTokenRes.fromJson(p)).data;
  }

  @override
  Future<Member> getUserInfo() async {
    Uri uri = getUri("/member/me");

    Response response = await interceptedClient.get(uri);

    return getData(response, (p0) => Member.fromJson(p0)).data;
  }


  @override
  Future<AuthorizationTokenRes> reissue(
      String accessToken, String refreshToken) async {
    Uri uri = getUri("/auth/token");

    Map<String, String> header = {"Content-Type": "application/json"};

    Map<String, dynamic> reqBody = {
      "accessToken": accessToken,
      "refreshToken": refreshToken
    };
    Response response =
    await client.post(uri, headers: header, body: jsonEncode(reqBody));

    return getData(response, (p0) => AuthorizationTokenRes.fromJson(p0)).data;
  }
}