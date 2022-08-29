import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/dio/app_dio.dart';
import 'package:retrofit/retrofit.dart';

part 'twitter_search_data_source.g.dart';

final twitterSearchDataSourceProvider = Provider((ref) => TwitterSearchDataSource(ref.read));

@RestApi()
abstract class TwitterSearchDataSource {
  factory TwitterSearchDataSource(Reader reader) => _TwitterSearchDataSource(reader(twitterDioProvider));
  @GET("//1.1/search/tweets.json?q={keyword}&result_type=mixed")
  Future<dynamic> getTweetSearch(
    @Header("Authorization: Bearer ") String bearer,
    @Path("apikey") String apikey,
    @Path("keyword") String keyword,
  );
}