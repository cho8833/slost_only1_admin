import 'package:slost_only1_admin/data/authorization_token_res.dart';
import 'package:slost_only1_admin/data/sign_in_req.dart';
import 'package:slost_only1_admin/model/member.dart';

abstract interface class AuthRepository {

  Future<AuthorizationTokenRes> signIn(SignInReq req);

  Future<Member> getUserInfo();

  Future<AuthorizationTokenRes> reissue(String accessToken, String refreshToken);
}