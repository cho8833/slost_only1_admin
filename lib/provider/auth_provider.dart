import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slost_only1_admin/data/authorization_token_res.dart';
import 'package:slost_only1_admin/data/sign_in_req.dart';
import 'package:slost_only1_admin/model/member.dart';
import 'package:slost_only1_admin/provider/token_provider.dart';
import 'package:slost_only1_admin/repository/auth_repository.dart';

class AuthProvider {
  // singleton
  static final AuthProvider _instance = AuthProvider._internal();

  factory AuthProvider() => _instance;

  AuthProvider._internal();

  void init(AuthRepository authRepository) {
    _repository = authRepository;
  }

  late final AuthRepository _repository;
  final TokenProvider tokenProvider = TokenProvider();

  ValueNotifier<bool> isLoggedIn = ValueNotifier(false);

  String? errorMessage;

  Member? me;

  Future<void> signIn(SignInReq req) async {
    await _repository.signIn(req).then((data) async {
      await _onSignIn(data);
    });
  }

  Future<void> _onSignIn(AuthorizationTokenRes res) async {
    await tokenProvider.storeAccessToken(res.accessToken);
    await tokenProvider.storeRefreshToken(res.refreshToken);
    await _repository.getUserInfo().then((user) {
      me = user;
    });
    isLoggedIn.value = true;
  }

  Future<void> signOut() async {
    await tokenProvider.deleteToken();
    me = null;
    isLoggedIn.value = false;
  }

  Future<void> checkSignIn() async {
    await _repository.getUserInfo().then((user) {
      me = user;
      isLoggedIn.value = true;
    }).catchError((e) {});
  }

}