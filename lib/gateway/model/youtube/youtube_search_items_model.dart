import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_app/gateway/model/youtube/youtube_search_result_model.dart';

part 'youtube_search_items_model.freezed.dart';
part 'youtube_search_items_model.g.dart';

@freezed
abstract class YoutubeSearchItemsModel with _$YoutubeSearchItemsModel {
  factory YoutubeSearchItemsModel({
    @Default('') String kind,
    @Default('') String etag,
    YoutubeSearchResultModel? id,

  }) = _YoutubeSearchItemsModel;

  factory YoutubeSearchItemsModel.fromJson(Map<String, dynamic> json) => _$YoutubeSearchItemsModelFromJson(json);

}
