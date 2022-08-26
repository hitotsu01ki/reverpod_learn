import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/repository/zip/zip_repository_impl.dart';
import 'package:riverpod_app/model/home/sub/zip_search_page_model.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/pages/utils/shared_preferences_provider.dart';

final zipNotifierProvider = StateNotifierProvider.autoDispose<ZipNotifier, ZipSearchPageModel>((ref) => ZipNotifier(ref.read));

class ZipNotifier extends StateNotifier<ZipSearchPageModel> {
  ZipNotifier(this._reader) : super(ZipSearchPageModel());

  final Reader _reader;

  late final _zipApi = _reader(zipRepositoryProvider);
  late final _prefs = _reader(sharedPreferencesFutureProvider.future);
  late final _log = _reader(debugLogPrintProvider);

  TextEditingController zipCodeController = TextEditingController(text: '1500001');

  Future<bool> searchWithZipcode() async {
    String zipcode = zipCodeController.text;
    if (zipcode == '') {
      return false;
    }
    if (zipcode.length != 7) {
      return false;
    }
    final result = await _zipApi.zipSearch(zipcode);
    return result.when(
        success: (success) {
          final model = success.first;
          state = state.copyWith(
            address: '${model.address1} ${model.address2} ${model.address3}',
            addressRead: '${model.kana1} ${model.kana2} ${model.kana3}',
            zipcode: model.zipcode,
          );
          return true;
        },
        failure: (failure) {
          _log.severe(failure.type);
          _log.severe(failure.message);
          state = state.copyWith(
            errorMessage: failure.message,
          );
          return false;
        },
    );
  }

}