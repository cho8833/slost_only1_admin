import 'package:shared_preferences/shared_preferences.dart';
import 'package:slost_only1_admin/repository/secure_storage.dart';

class SecureStorageImpl implements SecureStorage {

  final SharedPreferences _prefs;

  static const String _accessTokenKey = "accessToken";

  static const String _refreshTokenKey = "refreshToken";

  static const String themeKey = "theme";

  SecureStorageImpl(this._prefs);

  @override
  String? getAccessToken() {
    return _prefs.getString(_accessTokenKey);
  }

  @override
  Future<void> storeAccessToken(String value) {
    return _prefs.setString(_accessTokenKey,  value);
  }

  @override
  Future<void> deleteAccessToken() {
    return _prefs.remove(_accessTokenKey);
  }

  @override
  Future<void> storeRefreshToken(String token) {
    return _prefs.setString(_refreshTokenKey, token);
  }

  @override
  String? getRefreshToken() {
    return _prefs.getString(_refreshTokenKey);
  }

  @override
  Future<void> deleteRefreshToken() {
    return _prefs.remove(_refreshTokenKey);
  }
}