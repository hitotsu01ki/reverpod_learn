import 'package:freezed_annotation/freezed_annotation.dart';

part 'zip_search_result_model.freezed.dart';
part 'zip_search_result_model.g.dart';

@freezed
abstract class ZipSearchResultModel with _$ZipSearchResultModel {
  factory ZipSearchResultModel({
    @Default('') String address1, // 住所１
    @Default('') String address2, // 住所２
    @Default('') String address3, // 住所３
    @Default('') String kana1, // 住所１（よみ）
    @Default('') String kana2, // 住所２（よみ）
    @Default('') String kana3, // 住所３（よみ）
    @Default('') String prefcode, //
    @Default('') String zipcode, // 郵便番号

  }) = _ZipSearchResultModel;

  factory ZipSearchResultModel.fromJson(Map<String, dynamic> json) => _$ZipSearchResultModelFromJson(json);

}
