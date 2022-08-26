import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

final lineSdkFutureProvider = FutureProvider((ref) async {
  final lineSdk = LineSDK.instance;
  const String lineChannelId = '1234567890';
  await lineSdk.setup(lineChannelId);

  return LineSdkUtils(lineSdk);
});


class LineSdkUtils {
  LineSdkUtils(this.lineSdk);
  final LineSDK lineSdk;

  final loginOption = LoginOption(false, 'normal', requestCode: 8192);
  final loginScopes = ['profile'];

  Future<UserProfile?> login() async {
    LoginResult result = await lineSdk.login(scopes: loginScopes, option: loginOption);
    return result.userProfile;
  }

  Future<UserProfile?> getProfile() async {
    try {
      return await lineSdk.getProfile();
    } catch (e) {
      return null;
    }
  }

  Future<void> logout() async {
    lineSdk.logout();
  }

}