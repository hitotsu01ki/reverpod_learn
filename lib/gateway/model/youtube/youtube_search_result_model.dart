import 'package:freezed_annotation/freezed_annotation.dart';

part 'youtube_search_result_model.freezed.dart';
part 'youtube_search_result_model.g.dart';

@freezed
abstract class YoutubeSearchResultModel with _$YoutubeSearchResultModel {
  factory YoutubeSearchResultModel({
    @Default('') String kind,
    @Default('') String videoId,

  }) = _YoutubeSearchResultModel;

  factory YoutubeSearchResultModel.fromJson(Map<String, dynamic> json) => _$YoutubeSearchResultModelFromJson(json);

}
