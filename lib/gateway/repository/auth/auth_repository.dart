import 'package:riverpod_app/model/auth/local_user_model.dart';
import 'package:riverpod_app/gateway/model/result.dart';

abstract class AuthRepository {
  Future<Result<void>> signOut();
  Future<Result<void>> whichSignIn();

  Future<Result<LocalUserModel>> emailSignIn(String email, String password);
  Future<Result<LocalUserModel>> emailSignUp(String email, String password, String confirmPassword);
  Future<Result<LocalUserModel>> signUpWithApple();
  Future<Result<LocalUserModel>> signUpWithGoogle();
  Future<Result<LocalUserModel>> signUpWithLine();

  Future<bool> isSignedWithEmail();
  Future<bool> isSignedWithApple();
  Future<bool> isSignedWithGoogle();
  Future<bool> isSignedWithLine();

  Future<Result<bool>> passwordReset(String email);
}
