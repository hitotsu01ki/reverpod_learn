import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum AppErrorType {
  network,
  badRequest,
  unauthorized,
  cancel,
  timeout,
  server,
  unknown,
}

class AppError {
  late String message;
  late AppErrorType type;

  AppError(Exception? error) {
    if (error is DioError) {
      debugPrint('AppError(DioError): '
          'type is ${error.type}, message is ${error.message}');
      message = error.message;
      switch (error.type) {
        case DioErrorType.other:
          if (error.error is SocketException) {
            // SocketException: Failed host lookup: '***'
            // (OS Error: No address associated with hostname, errno = 7)
            type = AppErrorType.network;
          } else {
            type = AppErrorType.unknown;
          }
          break;
        case DioErrorType.connectTimeout:
        case DioErrorType.receiveTimeout:
          type = AppErrorType.timeout;
          break;
        case DioErrorType.sendTimeout:
          type = AppErrorType.network;
          break;
        case DioErrorType.response:
          // TODO(api): need define more http status;
          switch (error.response?.statusCode) {
            case HttpStatus.badRequest: // 400
              type = AppErrorType.badRequest;
              break;
            case HttpStatus.unauthorized: // 401
              type = AppErrorType.unauthorized;
              break;
            case HttpStatus.internalServerError: // 500
            case HttpStatus.badGateway: // 502
            case HttpStatus.serviceUnavailable: // 503
            case HttpStatus.gatewayTimeout: // 504
              type = AppErrorType.server;
              break;
            default:
              type = AppErrorType.unknown;
              break;
          }
          break;
        case DioErrorType.cancel:
          type = AppErrorType.cancel;
          break;
        default:
          type = AppErrorType.unknown;
      }
    } else if(error is FirebaseAuthException) {
      switch(error.code) {
        case 'unknown':
          type = AppErrorType.unknown;
          message = '正しい値を入力してください';
          break;
        case 'invalid-email':
          type = AppErrorType.badRequest;
          message = 'メールアドレスが不正です';
          break;
        case 'user-disabled':
          type = AppErrorType.badRequest;
          message = '無効なユーザーです';
          break;
        case 'user-not-found':
          type = AppErrorType.badRequest;
          message = '入力したユーザーは登録されていません';
          break;
        case 'wrong-password':
          type = AppErrorType.badRequest;
          message = 'パスワードが間違っています';
          break;
        case 'too-many-requests':
          type = AppErrorType.badRequest;
          message = 'リクエスト上限を超えました';
          break;
        default:
          type = AppErrorType.unknown;
          message = '原因不明のエラーが発生しました';
          break;
      }
    } else if(error is PlatformException) {
      switch(error.code) {
        case '3003':
        default:
          type = AppErrorType.cancel;
          message = 'ログイン処理がキャンセルされました';
          break;
      }
    } else {
      debugPrint('AppError(UnKnown): $error');
      type = AppErrorType.unknown;
      message = 'AppError: $error';
    }
  }
}
