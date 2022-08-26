import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:riverpod_app/gateway/auth/enum_sign_in.dart';

abstract class AuthDataSource {
  Future<void> signOut();
  Future<List<EnumSignInType>> whichSignIn();

  // Email Login
  Future<UserCredential> signInEmail(String email, String password);
  Future<UserCredential> signUpEmail(String email, String password, String confirmPassword);
  Future<void> resetPasswordEmail(String email);

  // SNS Login
  Future<UserCredential> signUpWithApple();
  Future<UserCredential> signUpWithGoogle();
  Future<UserProfile> signUpWithLine();
}
