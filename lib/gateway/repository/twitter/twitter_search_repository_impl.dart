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
  final twitter = TwitterApi(
    bearerToken: Constants.of().twitterBearerToken,
    oauthTokens: OAuthTokens(
      accessToken: Constants.of().twitterAccessToken,
      accessTokenSecret: Constants.of().twitterAccessTokenSecret,
      consumerKey: Constants.of().twitterConsumerKey,
      consumerSecret: Constants.of().twitterConsumerSecret,
    ),
  );

  @override
  Future<Result<List<TweetV2Response>>> tweetSearch(String keyword) async {
    try {

      final tweets = await twitter.tweetsService.searchRecent(
        query: keyword,
        maxResults: 11,
        expansions: [TweetExpansion.authorId, TweetExpansion.referencedTweetsId, TweetExpansion.attachmentsMediaKeys, TweetExpansion.referencedTweetsIdAuthorId],
        tweetFields: [TweetField.createdAt, TweetField.authorId, TweetField.attachments],
        userFields: [UserField.id, UserField.name, UserField.username, UserField.url, UserField.description, UserField.verified, UserField.profileImageUrl, UserField.pinnedTweetId],
        mediaFields: [MediaField.url, MediaField.previewImageUrl],
      );
      _log.config(tweets.data.length);

      List<TweetV2> tweetsV2 = [];
      List<UserV2> userV2 = [];
      List<MediaV2> mediaV2 = [];
      if (tweets.includes != null) {
        if (tweets.includes!.tweets != null) {
          tweetsV2 = tweets.includes!.tweets!.map((m) => TweetV2.fromJson(m.toJson())).toList();
        }

        if (tweets.includes!.users != null) {
          userV2 = tweets.includes!.users!.map((m) => UserV2.fromJson(m.toJson())).toList();
        }

        if (tweets.includes!.media != null) {
          mediaV2 = tweets.includes!.media!.map((m) => MediaV2.fromJson(m.toJson())).toList();
        }
      }

      // _log.config(tweetsUser);
      final tweetsResponseList = tweets.data.map(
        (data) => TweetV2Response(
          data: data.toJson(),
          includes: TweetV2Includes(
            tweets: tweetsV2,
            users:  userV2,
            media:  mediaV2,
          )
        )
      ).toList();

      return Result.success(data: tweetsResponseList);
    } on Exception catch (e) {
      return Result.failure(error: AppError(e));
    }

  }

  Future<Result<UserData>> userLookup(String keyword) async {
    try {

      final tweets = await twitter.usersService.lookupByName(
        username: keyword,
        tweetFields: [TweetField.createdAt, TweetField.authorId, TweetField.attachments],
        userFields: [UserField.id, UserField.name, UserField.username, UserField.url, UserField.description, UserField.verified, UserField.profileImageUrl, UserField.pinnedTweetId],
      );
      _log.config(tweets.data);

      return Result.success(data: tweets.data);
    } on Exception catch (e) {
      return Result.failure(error: AppError(e));
    }

  }

  Future<Result<List<TweetV2Response>>> tweetLinked(String keyword) async {
    try {

      final tweets = await twitter.tweetsService.lookupTweets(
        userId: keyword,
        maxResults: 11,
        expansions: [TweetExpansion.authorId, TweetExpansion.referencedTweetsId, TweetExpansion.attachmentsMediaKeys, TweetExpansion.referencedTweetsIdAuthorId],
        tweetFields: [TweetField.createdAt, TweetField.authorId, TweetField.attachments],
        userFields: [UserField.id, UserField.name, UserField.username, UserField.url, UserField.description, UserField.verified, UserField.profileImageUrl, UserField.pinnedTweetId],
        mediaFields: [MediaField.url, MediaField.previewImageUrl],
      );
      _log.config(tweets.data.length);

      List<TweetV2> tweetsV2 = [];
      List<UserV2> userV2 = [];
      List<MediaV2> mediaV2 = [];
      if (tweets.includes != null) {
        if (tweets.includes!.tweets != null) {
          tweetsV2 = tweets.includes!.tweets!.map((m) => TweetV2.fromJson(m.toJson())).toList();
        }

        if (tweets.includes!.users != null) {
          userV2 = tweets.includes!.users!.map((m) => UserV2.fromJson(m.toJson())).toList();
        }

        if (tweets.includes!.media != null) {
          mediaV2 = tweets.includes!.media!.map((m) => MediaV2.fromJson(m.toJson())).toList();
        }
      }

      // _log.config(tweetsUser);
      final tweetsResponseList = tweets.data.map(
              (data) => TweetV2Response(
              data: data.toJson(),
              includes: TweetV2Includes(
                tweets: tweetsV2,
                users:  userV2,
                media:  mediaV2,
              )
          )
      ).toList();

      return Result.success(data: tweetsResponseList);
    } on Exception catch (e) {
      return Result.failure(error: AppError(e));
    }

  }

  Future<Result<TweetData>> tweetLookupById(String keyword) async {
    try {
      // https://twitter.com/_001j/status/1564623070307835908?s=21&t=CRY6QPKrFohmBejYniMPSA

      String tid = 'https://twitter.com/_001j/status/1564446309620551682?s=21&t=CRY6QPKrFohmBejYniMPSA';


      final tweets = await twitter.tweetsService.lookupById(
        tweetId: keyword,
        tweetFields: [TweetField.createdAt, TweetField.authorId, TweetField.attachments],
        userFields: [UserField.id, UserField.name, UserField.username, UserField.url, UserField.description, UserField.verified, UserField.profileImageUrl, UserField.pinnedTweetId],
      );
      _log.config(tweets.data);

      return Result.success(data: tweets.data);
    } on Exception catch (e) {
      return Result.failure(error: AppError(e));
    }

  }

}
