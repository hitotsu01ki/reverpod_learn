import 'package:riverpod_app/gateway/dio/result.dart';
import 'package:spotify/spotify.dart';

abstract class SpotifySearchRepository {
  Future<Result<List<Track>>> trackSearch(String keyword);
}