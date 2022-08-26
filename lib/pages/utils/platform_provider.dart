import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final platformFutureProvider = FutureProvider<PlatformUtils>((ref) async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  return PlatformUtils(packageInfo);
});


class PlatformUtils {
  PlatformUtils(this.packageInfo);
  PackageInfo packageInfo;

  String get flavor => const String.fromEnvironment('FLAVOR');

  String get appName => packageInfo.appName;
  String get packageName => packageInfo.packageName;
  String get version => packageInfo.version;
  String get buildNumber => packageInfo.buildNumber;

  bool isAndroid() {
    return Platform.isAndroid;
  }

  bool isIOS() {
    return Platform.isIOS;
  }

  // print(flavor); // dev
  // print(appName); // RivApp.dev
  // print(packageName); // jp.co.thinkapp.riverpodapp.dev
  // print(version); // 1.0.0
  // print(buildNumber); // 1

}
