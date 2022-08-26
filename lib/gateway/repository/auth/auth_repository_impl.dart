import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/app_error.dart';
import 'package:riverpod_app/gateway/auth/auth_data_source_provider.dart';
import 'package:riverpod_app/gateway/auth/enum_sign_in.dart';
import 'package:riverpod_app/gateway/repository/auth/auth_data_source_impl.dart';
import 'package:riverpod_app/gateway/repository/auth/auth_repository.dart';
import 'package:riverpod_app/model/auth/local_user_model.dart';
import 'package:riverpod_app/gateway/model/result.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._reader);

  final Reader _reader;

  late final AuthDataSourceImpl _dataSource = _reader(authDataSourceProvider);
  late final _log = _reader(debugLogPrintProvider);

  @override
  Future<Result<void>> signOut() {
    return Result.guardFuture(_dataSource.signOut);
  }

  @override
  Future<Result<List<EnumSignInType>>> whichSignIn() {
    return Result.guardFuture(_dataSource.whichSignIn);
  }

  @override
  Future<Result<LocalUserModel>> emailSignIn(String email, String password) async {
    try {
      final result = await _dataSource.signInEmail(email, password);
      final authUser = result.user!;
      return Result.success(
        data: LocalUserModel(
          displayName: authUser.displayName,
          email: authUser.email,
          phoneNumber: authUser.phoneNumber,
          photoURL: authUser.photoURL,
          isEmailVerified: authUser.emailVerified,
          uid: authUser.uid,
        ),
      );
    } on Exception catch (e) {
      _log.severe(e);
      return Result.failure(error: AppError(e));
    }
  }

  @override
  Future<Result<LocalUserModel>> emailSignUp(String email, String password, String confirmPassword) async {
    try {
      final result = await _dataSource.signUpEmail(email, password, confirmPassword);
      _log.info(result);
      final authUser = result.user!;
      await authUser.sendEmailVerification();
      return Result.success(
          data: LocalUserModel(
          displayName: authUser.displayName,
          email: authUser.email,
          phoneNumber: authUser.phoneNumber,
          photoURL: authUser.photoURL,
          isEmailVerified: authUser.emailVerified,
          uid: authUser.uid,
        ),
      );
    } on Exception catch (e) {
      _log.severe(e);
      return Result.failure(error: AppError(e));
    }
  }

  @override
  Future<Result<bool>> passwordReset(String email) async {
    try {
      await _dataSource.resetPasswordEmail(email);
      return const Result.success(data: true);
    } on Exception catch (e) {
      _log.severe(e);
      return Result.failure(error: AppError(e));
    }
  }

  @override
  Future<Result<LocalUserModel>> signUpWithApple() {
    // TODO: implement signUpWithApple
    throw UnimplementedError();
  }

  @override
  Future<Result<LocalUserModel>> signUpWithGoogle() {
    // TODO: implement signUpWithApple
    throw UnimplementedError();
  }

  @override
  Future<Result<LocalUserModel>> signUpWithLine() async {
    try {
      UserProfile profile = await _dataSource.signUpWithLine();
      return Result.success(
          data: LocalUserModel(
          displayName: profile.displayName,
          uid: profile.userId,
        ),
      );
    } on Exception catch (e) {
      _log.severe(e);
      return Result.failure(error: AppError(e));
    }
  }

  @override
  Future<bool> isSignedWithEmail() async {
    try {
      final signInType = await _dataSource.whichSignIn();
      final result = signInType.firstWhere((element) => element == EnumSignInType.email);
      if (result == EnumSignInType.email) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ログイン履歴なし
      return false;
    }
  }

  @override
  Future<bool> isSignedWithApple() async {
    try {
      final signInType = await _dataSource.whichSignIn();
      final result = signInType.firstWhere((element) => element == EnumSignInType.apple);
      if (result == EnumSignInType.apple) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ログイン履歴なし
      return false;
    }
  }

  @override
  Future<bool> isSignedWithGoogle() async {
    try {
      final signInType = await _dataSource.whichSignIn();
      final result = signInType.firstWhere((element) => element == EnumSignInType.google);
      if (result == EnumSignInType.google) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ログイン履歴なし
      return false;
    }
  }

  @override
  Future<bool> isSignedWithLine() async {
    try {
      final signInType = await _dataSource.whichSignIn();
      final result = signInType.firstWhere((element) => element == EnumSignInType.line);
      if (result == EnumSignInType.line) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      // ログイン履歴なし
      return false;
    }
  }
}
