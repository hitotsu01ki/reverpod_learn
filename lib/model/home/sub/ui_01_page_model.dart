import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spotify/spotify.dart';
import 'package:tweet_ui/models/api/v2/tweet_v2.dart';

part 'ui_01_page_model.freezed.dart';

@freezed
abstract class UI01PageModel with _$UI01PageModel {
  factory UI01PageModel({
    @Default([]) List<String> liveIds, // youtube live id
    @Default([]) List<TweetV2Response> tweetV2List, // twitter tweets data
    @Default(false) bool isTweetsPhotoPriority, // tweets ui view
    @Default([]) List<Track> spotifyTracks, // spotify track
    @Default('') String errorMessage, //エラーメッセージ
  }) = _UI01PageModel;
}