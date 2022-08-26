import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_app/gateway/model/zip_search/zip_search_result_model.dart';

part 'zip_search_base_model.freezed.dart';
part 'zip_search_base_model.g.dart';

@freezed
abstract class ZipSearchBaseModel with _$ZipSearchBaseModel {
  factory ZipSearchBaseModel({
    @Default('') String message,
    @Default([]) List<ZipSearchResultModel> results,
    @Default(0) int status,

  }) = _ZipSearchBaseModel;

  factory ZipSearchBaseModel.fromJson(Map<String, dynamic> json) => _$ZipSearchBaseModelFromJson(json);

}
