import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/app_error.dart';
import 'package:riverpod_app/gateway/dio/constants.dart';
import 'package:riverpod_app/gateway/dio/result.dart';
import 'package:riverpod_app/gateway/model/youtube/youtube_search_base_model.dart';
import 'package:riverpod_app/gateway/model/youtube/youtube_search_items_model.dart';
import 'package:riverpod_app/gateway/repository/youtube/youtube_search_data_source.dart';
import 'package:riverpod_app/gateway/repository/youtube/youtube_search_repository.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';

final youtubeSearchRepositoryProvider = Provider((ref) => YoutubeSearchRepositoryImpl(ref.read));

class YoutubeSearchRepositoryImpl implements YoutubeSearchRepository {
  YoutubeSearchRepositoryImpl(this._reader);
  final Reader _reader;

  late final YoutubeSearchDataSource _youtubeSearchDataSource = _reader(youtubeSearchDataSourceProvider);
  late final _log = _reader(debugLogPrintProvider);

  @override
  Future<Result<List<YoutubeSearchItemsModel>>> youtubeLiveSearch(String keyword) async {
    try {
      final result = _youtubeSearchDataSource.getYoutubeLiveSearch(
        Constants.of().googleApiKey,
        keyword,
        'live',
      );

      YoutubeSearchBaseModel baseModel = YoutubeSearchBaseModel.fromJson(await result);

      return Result.success(data: baseModel.items);
    } on Exception catch (e) {
      return Result.failure(error: AppError(e));
    }

  }

}
