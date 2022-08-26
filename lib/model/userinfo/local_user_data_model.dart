import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'local_user_data_model.freezed.dart';

@freezed
abstract class LocalUserDataModel with _$LocalUserDataModel {
  factory LocalUserDataModel({
    String? userId,
    String? imageUrl,
    String? name,
    String? email,
  }) = _LocalUserDataModel;

  factory LocalUserDataModel.fromFirebaseAuth(User firebaseUser) {
    return LocalUserDataModel(
      userId: firebaseUser.uid,
      imageUrl: firebaseUser.photoURL,
      name: firebaseUser.displayName,
      email: firebaseUser.email,
    );
  }
}