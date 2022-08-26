import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/auth/enum_sign_in.dart';
import 'package:riverpod_app/gateway/auth/firebase_auth_provider.dart';
import 'package:riverpod_app/gateway/auth/line_sdk_provider.dart';
import 'package:riverpod_app/gateway/repository/auth/auth_data_source.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';

class AuthDataSourceImpl implements AuthDataSource {
  AuthDataSourceImpl(this._reader);

  final Reader _reader;

  late final FirebaseAuth _firebaseAuth = _reader(firebaseAuthProvider);
  late final _lineSdk = _reader(lineSdkFutureProvider.future);
  late final _log = _reader(debugLogPrintProvider);

  @override
  Future<void> signOut() async {

    // FIREBASEでログインの場合
    if (_firebaseAuth.currentUser != null) {
      await _firebaseAuth.signOut();
      _log.info('FIREBASE ログアウト完了');
    }

    // LINEでログイン済みの場合
    final line = await _lineSdk;
    if (await line.getProfile() != null) {
      await line.logout();
      _log.info('LINE ログアウト完了');
    }
  }

  @override
  Future<List<EnumSignInType>> whichSignIn() async {
    List<EnumSignInType> signInType = [];

    // FIREBASEでログインの場合 TODO 要テスト
    final firebaseCurrentUser = _firebaseAuth.currentUser;
    if (firebaseCurrentUser != null) {
      final providerData = firebaseCurrentUser.providerData;
      _log.info('FIREBASE サインイン済み[$providerData]');

      for (final data in providerData) {
        if (data.providerId == EnumSignInType.email.providerData) {
          signInType.add(EnumSignInType.email);
        }
        if (data.providerId == EnumSignInType.apple.providerData) {
          signInType.add(EnumSignInType.apple);
        }
        if (data.providerId == EnumSignInType.google.providerData) {
          signInType.add(EnumSignInType.google);
        }
      }
    }

    // LINEでログイン済みの場合
    final line = await _lineSdk;
    final lineProfile = await line.getProfile();
    if (lineProfile != null) {
      _log.info('LINE サインイン済み[$lineProfile]');
      signInType.add(EnumSignInType.line);
    }

    return signInType;
  }

  @override
  Future<UserCredential> signInEmail(String email, String password) async {
    _log.fine(email);
    _log.fine(password);
    // Firebase認証開始
    return await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<UserCredential> signUpEmail(String email, String password, String confirmPassword) async {
    _log.fine(email);
    _log.fine(password);
    _log.fine(confirmPassword);
    return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
  }

  @override
  Future<void> resetPasswordEmail(String email) async {
    _log.fine(email);
    // パスワード再設定メール送信
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<UserCredential> signUpWithApple() {
    // TODO: implement signUpWithApple
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signUpWithGoogle() {
    // TODO: implement signUpWithApple
    throw UnimplementedError();
  }

  @override
  Future<UserProfile> signUpWithLine() async {
    final line = await _lineSdk;
    // 外部のLINE認証
    final result = await line.login();
    return result!;
  }
}
