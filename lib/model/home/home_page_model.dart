import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_page_model.freezed.dart';

@freezed
abstract class HomePageModel with _$HomePageModel {
  factory HomePageModel({
    @Default('') String errorMessage, //エラーメッセージ
  }) = _HomePageModel;
}