import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/dio/app_dio.dart';
import 'package:retrofit/retrofit.dart';

part 'youtube_search_data_source.g.dart';

final youtubeSearchDataSourceProvider = Provider((ref) => YoutubeSearchDataSource(ref.read));

@RestApi()
abstract class YoutubeSearchDataSource {
  factory YoutubeSearchDataSource(Reader reader) => _YoutubeSearchDataSource(reader(googleDioProvider));
  @GET("/youtube/v3/search?key={apikey}&type=video&part=id&q={keyword}&safeSearch=moderate&eventType={eventType}")
  Future<dynamic> getYoutubeLiveSearch(
    @Path("apikey") String apikey,
    @Path("keyword") String keyword,
    @Path("eventType") String eventType,
  );
}
