import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_user_model.freezed.dart';
part 'local_user_model.g.dart';

@freezed
abstract class LocalUserModel with _$LocalUserModel {
  factory LocalUserModel({
    String? displayName, //表示名
    String? email,   //メールアドレス
    String? phoneNumber,  //電話番号
    String? photoURL, //画像URL
    bool? isEmailVerified,   //メール認証済みか？
    String? uid,  //uid
  }) = _LocalUserModel;

  factory LocalUserModel.fromJson(Map<String, dynamic> json) => _$LocalUserModelFromJson(json);

  factory LocalUserModel.fromFirebaseAuth(User firebaseUser) {
    return LocalUserModel(
      displayName: firebaseUser.displayName,
      email: firebaseUser.email,
      phoneNumber: firebaseUser.phoneNumber,
      photoURL: firebaseUser.photoURL,
      isEmailVerified: firebaseUser.emailVerified,
      uid: firebaseUser.uid,
    );
  }
}