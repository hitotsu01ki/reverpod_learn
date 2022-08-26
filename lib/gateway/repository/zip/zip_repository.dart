import 'package:riverpod_app/gateway/dio/result.dart';
import 'package:riverpod_app/gateway/model/zip_search/zip_search_result_model.dart';

abstract class ZipRepository {
  Future<Result<List<ZipSearchResultModel>>> zipSearch(String keyword);
  Future<Result<List<ZipSearchResultModel>>> zipCustomSearch(String keyword);
}