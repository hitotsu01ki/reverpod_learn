import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/app_error.dart';
import 'package:riverpod_app/gateway/dio/constants.dart';
import 'package:riverpod_app/gateway/dio/result.dart';
import 'package:riverpod_app/gateway/model/zip_search/zip_search_base_model.dart';
import 'package:riverpod_app/gateway/model/zip_search/zip_search_result_model.dart';
import 'package:riverpod_app/gateway/repository/zip/zip_data_source.dart';
import 'package:riverpod_app/gateway/repository/zip/zip_repository.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';

final zipRepositoryProvider = Provider((ref) => ZipRepositoryImpl(ref.read));

class ZipRepositoryImpl implements ZipRepository {
  ZipRepositoryImpl(this._reader);
  final Reader _reader;

  late final ZipDataSource _zipDataSource = _reader(zipDataSourceProvider);
  late final _log = _reader(debugLogPrintProvider);

  @override
  Future<Result<List<ZipSearchResultModel>>> zipSearch(String keyword) async {
    try {
      final result = _zipDataSource.getZipSearch(
        keyword
      );

      ZipSearchBaseModel api = ZipSearchBaseModel.fromJson(jsonDecode(await result));

      return Result.success(data: api.results);
    } on Exception catch (e) {
      return Result.failure(error: AppError(e));
    }

  }

  @override
  Future<Result<List<ZipSearchResultModel>>> zipCustomSearch(String keyword) async {
    try {
      final Map<String, dynamic> body = {
        'keyword': keyword,
        'id':'1',
      };
      final result = _zipDataSource.postZipSearch(
        Constants.of().contentType,
        Constants.of().apiKey,
        body,
      );

      ZipSearchBaseModel api = ZipSearchBaseModel.fromJson(await result);

      return Result.success(data: api.results);
    } on Exception catch (e) {
      return Result.failure(error: AppError(e));
    }

  }

}
