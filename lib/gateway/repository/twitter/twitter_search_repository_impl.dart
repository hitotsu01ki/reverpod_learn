import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/app_error.dart';
import 'package:riverpod_app/gateway/dio/constants.dart';
import 'package:riverpod_app/gateway/dio/result.dart';
import 'package:riverpod_app/gateway/repository/twitter/twitter_search_repository.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:tweet_ui/models/api/v2/entities/media_v2.dart';
import 'package:tweet_ui/models/api/v2/tweet_v2.dart';
import 'package:tweet_ui/models/api/v2/user_v2.dart';
import 'package:twitter_api_v2/twitter_api_v2.dart';

final twitterSearchRepositoryProvider = Provider((ref) => TwitterSearchRepositoryImpl(ref.read));

class TwitterSearchRepositoryImpl implements TwitterSearchRepository {
  TwitterSearchRepositoryImpl(this._reader);

  final Reader _reader;

  late final _log = _reader(debugLogPrintProvider);

  @override
  Future<Result<List<TweetV2Response>>> tweetSearch(String keyword) async {
    try {

      final twitter = TwitterApi(
        bearerToken: Constants.of().twitterBearerToken,
        oauthTokens: OAuthTokens(
          accessToken: Constants.of().twitterAccessToken,
          accessTokenSecret: Constants.of().twitterAccessTokenSecret,
          consumerKey: Constants.of().twitterConsumerKey,
          consumerSecret: Constants.of().twitterConsumerSecret,
        ),
      );

      final tweets = await twitter.tweetsService.searchRecent(
        query: keyword,
        maxResults: 20,
        expansions: [TweetExpansion.authorId, TweetExpansion.referencedTweetsId, TweetExpansion.attachmentsMediaKeys, TweetExpansion.referencedTweetsIdAuthorId],
        tweetFields: [TweetField.createdAt, TweetField.authorId, TweetField.attachments],
        userFields: [UserField.id, UserField.name, UserField.username, UserField.url, UserField.description, UserField.verified, UserField.profileImageUrl, UserField.pinnedTweetId],
        mediaFields: [MediaField.url, MediaField.previewImageUrl],
      );
      _log.config(tweets.data.length);

      // _log.config(tweetsUser);
      final tweetsResponseList = tweets.data.map(
        (data) => TweetV2Response(
          data: data.toJson(),
          includes: TweetV2Includes(
            // tweets:  tweets.includes!.tweets!.map((m) => TweetV2.fromJson(m.toJson())).toList(),
            users:  tweets.includes!.users!.map((m) => UserV2.fromJson(m.toJson())).toList(),
            media:  tweets.includes!.media!.map((m) => MediaV2.fromJson(m.toJson())).toList(),
          )
        )
      ).toList();

      return Result.success(data: tweetsResponseList);
    } on Exception catch (e) {
      return Result.failure(error: AppError(e));
    }

  }

}
