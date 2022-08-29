import 'package:riverpod_app/gateway/dio/result.dart';
import 'package:riverpod_app/gateway/model/youtube/youtube_search_items_model.dart';

abstract class YoutubeSearchRepository {
  Future<Result<List<YoutubeSearchItemsModel>>> youtubeLiveSearch(String keyword);
}