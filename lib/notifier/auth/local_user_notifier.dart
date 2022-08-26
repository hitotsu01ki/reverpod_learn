import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/model/auth/local_user_model.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/pages/utils/shared_preferences_provider.dart';
import 'package:riverpod_app/route/app_route.dart';
import 'package:riverpod_app/route/auto_route_provider.dart';

final localUserNotifierProvider = StateNotifierProvider<LocalUserNotifier, LocalUserModel>((ref) => LocalUserNotifier(ref.read));

class LocalUserNotifier extends StateNotifier<LocalUserModel> {
  LocalUserNotifier(this._reader) : super(LocalUserModel()) {

    // アプリ起動時、prefs.localUserに何も保存されてなければ、ログイン画面へ
    Future(() async {
      final prefs = await _prefs;
      final localUser = prefs.localUser.getModel();
      if (localUser == null) {
        _log.fine('prefs.localUserが空：ログイン画面へ遷移する');
        _router.push = const SignInRoute();
        return false;
      } else {
        _log.fine('localUserStateに値をセットする');
        setLocal(localUser);
        return true;
      }
    });
  }

  final Reader _reader;

  late final _prefs = _reader(sharedPreferencesFutureProvider.future);
  late final _router = _reader(autoRouterProvider);
  late final _log = _reader(debugLogPrintProvider);

  void setLocal(LocalUserModel model){
    _log.fine(model);
    state = model;
  }

  getLocal(){
    return state;
  }


}
