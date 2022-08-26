import 'package:freezed_annotation/freezed_annotation.dart';

part 'zip_search_page_model.freezed.dart';

@freezed
abstract class ZipSearchPageModel with _$ZipSearchPageModel {
  factory ZipSearchPageModel({
    @Default('') String address, //住所
    @Default('') String addressRead, //住所よみ
    @Default('') String zipcode, //住所番号
    @Default('') String errorMessage, //エラーメッセージ
  }) = _ZipSearchPageModel;
}