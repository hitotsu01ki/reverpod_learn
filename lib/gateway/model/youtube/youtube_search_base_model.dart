import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_app/gateway/model/youtube/youtube_search_items_model.dart';

part 'youtube_search_base_model.freezed.dart';
part 'youtube_search_base_model.g.dart';

@freezed
abstract class YoutubeSearchBaseModel with _$YoutubeSearchBaseModel {
  factory YoutubeSearchBaseModel({
    @Default('') String nextPageToken,
    @Default([]) List<YoutubeSearchItemsModel> items,

  }) = _YoutubeSearchBaseModel;

  factory YoutubeSearchBaseModel.fromJson(Map<String, dynamic> json) => _$YoutubeSearchBaseModelFromJson(json);
}
