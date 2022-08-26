import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/auth/auth_repository_provider.dart';
import 'package:riverpod_app/gateway/auth/enum_sign_in.dart';
import 'package:riverpod_app/gateway/repository/auth/auth_repository_impl.dart';
import 'package:riverpod_app/model/userinfo/sign_in_page_model.dart';
import 'package:riverpod_app/notifier/auth/local_user_notifier.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/pages/utils/shared_preferences_provider.dart';

final signInNotifierProvider = StateNotifierProvider<SignInNotifier, SignInPageModel>((ref) => SignInNotifier(ref.read));

class SignInNotifier extends StateNotifier<SignInPageModel> {
  SignInNotifier(this._reader) : super(SignInPageModel());

  final Reader _reader;

  late final AuthRepositoryImpl _repository = _reader(authRepositoryProvider);
  late final _local = _reader(localUserNotifierProvider.notifier);
  late final _prefs = _reader(sharedPreferencesFutureProvider.future);
  late final _log = _reader(debugLogPrintProvider);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  EnumSignInType? signInType; // どのログインで利用規約に遷移したか(email, apple, google, line)

  Future<bool> signInWithEmail() async {
    String email = emailController.text;
    String password = passwordController.text;

    final result = await _repository.emailSignIn(email, password);
    return result.when(success: (user) async {
      _local.setLocal(user);
      final prefs = await _prefs;
      await prefs.localUser.set(user);
      return true;
    }, failure: (e) {
      _log.severe(e.message);
      state = state.copyWith(errorMessage: e.message);
      return false;
    });
  }

  Future<bool> signInWithApple() async {
    _log.info('Apple:未実装');
    return false;
  }

  Future<bool> signInWithGoogle() async {
    _log.info('Google:未実装');
    return false;
  }

  Future<bool> signUpWithEmail() async {
    _log.info('Email:未実装');
    return false;
  }

  Future<bool> signInWithLine() async {
    final result = await _repository.signUpWithLine();
    return result.when(success: (user) async {
      _log.fine('LINE:ログイン完了：${user.displayName} | ${user.uid}');
      _local.setLocal(user);
      final prefs = await _prefs;
      await prefs.localUser.set(user);
      return true;
    }, failure: (e) {
      _log.severe(e.message);
      return false;
    });
  }

  Future<bool> isSignedWithLine() async {
    return await _repository.isSignedWithLine();
  }
}
