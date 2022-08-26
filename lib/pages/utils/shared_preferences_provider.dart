import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/model/auth/local_user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesFutureProvider = FutureProvider<SharedPreferencesUtils>((ref) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return SharedPreferencesUtils(prefs);
});


class SharedPreferencesUtils {
  SharedPreferencesUtils(this.prefs);
  final SharedPreferences prefs;

  $PrefLocalUser get localUser => $PrefLocalUser(prefs);
  $PrefLocalUserList get localUserList => $PrefLocalUserList(prefs);

}

class $PrefLocalUser {
  const $PrefLocalUser(this.prefs);
  final SharedPreferences prefs;
  final keyName = 'localUser';

  Future<void> set(LocalUserModel model) async {
    await prefs.setString(keyName, jsonEncode(model.toJson()));
  }

  String? get() {
    final String? json = prefs.getString(keyName);
    return json;
  }

  LocalUserModel? getModel() {
    final String? json = get();
    if (json != null) {
      return LocalUserModel.fromJson(jsonDecode(json));
    }
    return null;
  }

  Future<bool> clear() async {
    return await prefs.remove(keyName);
  }

}

abstract class $PrefList {
  Future<void> setList(List<String> jsonList);
  Future<void> addList(String homeJson);
  List<String> getList();
  List<dynamic> getModelList();
  Future<bool> clearList();
}

class $PrefLocalUserList implements $PrefList {
  const $PrefLocalUserList(this.prefs);
  final SharedPreferences prefs;
  final keyName = 'localUserList';

  @override
  Future<void> setList(List<String> jsonList) async {
    await prefs.setStringList(keyName, jsonList);
  }

  @override
  Future<void> addList(String homeJson) async {
    List<String> jsonList = getList();
    jsonList.add(homeJson);
    await prefs.setStringList(keyName, jsonList);
  }

  @override
  List<String> getList() {
    final List<String> jsonList = prefs.getStringList(keyName) ?? [];
    return jsonList;
  }

  @override
  List<LocalUserModel> getModelList() {
    final List<String> homeJsonList = prefs.getStringList(keyName) ?? [];
    List<LocalUserModel> modelList = [];
    for (final homeJson in homeJsonList) {
      final model = LocalUserModel.fromJson(jsonDecode(homeJson));
      modelList.add(model);
    }
    return modelList;
  }

  @override
  Future<bool> clearList() async {
    return await prefs.remove(keyName);
  }
}
