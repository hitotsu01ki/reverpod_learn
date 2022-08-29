import 'package:freezed_annotation/freezed_annotation.dart';

part 'twitter_search_result_model.freezed.dart';
part 'twitter_search_result_model.g.dart';

@freezed
abstract class TwitterSearchResultModel with _$TwitterSearchResultModel {
  factory TwitterSearchResultModel({
    @Default('') String kind,
    @Default('') String videoId,

  }) = _TwitterSearchResultModel;

  factory TwitterSearchResultModel.fromJson(Map<String, dynamic> json) => _$TwitterSearchResultModelFromJson(json);

}
