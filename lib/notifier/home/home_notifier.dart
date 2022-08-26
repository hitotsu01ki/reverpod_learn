import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/model/home/home_page_model.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/pages/utils/shared_preferences_provider.dart';

final homeNotifierProvider = StateNotifierProvider<HomeNotifier, HomePageModel>((ref) => HomeNotifier(ref.read));

class HomeNotifier extends StateNotifier<HomePageModel> {
  HomeNotifier(this._reader) : super(HomePageModel());

  final Reader _reader;

  late final _prefs = _reader(sharedPreferencesFutureProvider.future);
  late final _log = _reader(debugLogPrintProvider);

}