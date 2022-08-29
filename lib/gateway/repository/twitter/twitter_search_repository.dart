import 'package:riverpod_app/gateway/dio/result.dart';
import 'package:tweet_ui/models/api/v2/tweet_v2.dart';

abstract class TwitterSearchRepository {
  Future<Result<List<TweetV2Response>>> tweetSearch(String keyword);
}