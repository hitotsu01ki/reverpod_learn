import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/app_error.dart';
import 'package:riverpod_app/gateway/dio/constants.dart';
import 'package:riverpod_app/gateway/dio/result.dart';
import 'package:riverpod_app/gateway/repository/spotify/spotify_search_repository.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:spotify/spotify.dart';

final spotifySearchRepositoryProvider = Provider((ref) => SpotifySearchRepositoryImpl(ref.read));

class SpotifySearchRepositoryImpl implements SpotifySearchRepository {
  SpotifySearchRepositoryImpl(this._reader);

  final Reader _reader;

  late final _log = _reader(debugLogPrintProvider);

  @override
  Future<Result<List<Track>>> trackSearch(String keyword) async {
    try {

      final credentials = SpotifyApiCredentials(Constants.of().spotifyApiKey, Constants.of().spotifyApiKeySecret);
      final spotify = SpotifyApi(credentials);
      final songs = await spotify.search.get(keyword, types: [SearchType.track]).first();

      List<Track> spotifyTracks = [];
      for (final s in songs) {
        var item = s.items;
        if (item == null) {
          continue;
        }
        for (final i in item) {
          if (i is Track) {
            spotifyTracks.add(i);
            _log.fine(i.name);
            // _log.fine(i.externalUrls!.spotify);
            // _log.fine(i.previewUrl);
          }
        }
      }

      spotifyTracks.shuffle();

      return Result.success(data: spotifyTracks);
    } on Exception catch (e) {
      return Result.failure(error: AppError(e));
    }
  }

}
