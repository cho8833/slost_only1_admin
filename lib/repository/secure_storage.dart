abstract class SecureStorage {
  Future<void> storeAccessToken(String value);
  String? getAccessToken();
  Future<void> deleteAccessToken();
  String? getRefreshToken();
  Future<void> storeRefreshToken(String token);
  Future<void> deleteRefreshToken();
}