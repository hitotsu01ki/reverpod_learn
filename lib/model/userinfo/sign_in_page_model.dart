import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_page_model.freezed.dart';

@freezed
abstract class SignInPageModel with _$SignInPageModel {
  factory SignInPageModel({
    @Default('') String errorMessage, //エラーメッセージ
  }) = _SignInPageModel;
}