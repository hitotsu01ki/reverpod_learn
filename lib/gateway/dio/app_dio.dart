import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_firebase_performance/dio_firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/dio/constants.dart';
import 'package:simple_logger/simple_logger.dart';
import 'package:ua_client_hints/ua_client_hints.dart';

final dioProvider = Provider((_) => AppDio.getInstance());
final zipDioProvider = Provider((_) => AppDio.getCustomInstance('https://zipcloud.ibsnet.co.jp'));
final spotifyDioProvider = Provider((_) => AppDio.getCustomInstance('https://api.spotify.com'));
final googleDioProvider = Provider((_) => AppDio.getCustomInstance('https://www.googleapis.com'));
final twitterDioProvider = Provider((_) => AppDio.getCustomInstance('https://api.twitter.com'));

// ignore: prefer_mixin
class AppDio with DioMixin implements Dio {
  AppDio._({required BaseOptions options}) {

    this.options = options;
    interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      options.headers.addAll(await userAgentClientHintsHeader());
      handler.next(options);
    }));

    // Firebase Performance
    interceptors.add(DioFirebasePerformanceInterceptor());

    if (kDebugMode) {
      // Local Log
      interceptors.add(LogInterceptor(
          request: false, requestHeader: false, requestBody: true, responseHeader: false, responseBody: true,
          logPrint: SimpleLogger().info,
      ));
    }

    httpClientAdapter = DefaultHttpClientAdapter();
  }

  static Dio getInstance() => AppDio._(
      options: BaseOptions(
        baseUrl: Constants.of().endpoint,
        contentType: Constants.of().contentType,
        connectTimeout: 10000, // 10sec
        sendTimeout: 10000,
        receiveTimeout: 10000,
      )
  );

  static Dio getCustomInstance(String baseUrl) => AppDio._(
      options: BaseOptions(
        baseUrl: baseUrl,
        contentType: Constants.of().contentType,
        connectTimeout: 10000, // 10sec
        sendTimeout: 10000,
        receiveTimeout: 10000,
      )
    );

}
