import 'dart:async';

import 'package:chaleno/chaleno.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/dio/constants.dart';
import 'package:riverpod_app/gateway/repository/spotify/spotify_search_repository_impl.dart';
import 'package:riverpod_app/gateway/repository/spotify/spotify_timer_impl.dart';
import 'package:riverpod_app/gateway/repository/twitter/twitter_search_repository_impl.dart';
import 'package:riverpod_app/gateway/repository/youtube/youtube_search_repository_impl.dart';
import 'package:riverpod_app/model/home/sub/ui_01_page_model.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/pages/utils/shared_preferences_provider.dart';
import 'package:riverpod_app/pages/utils/timer_provider.dart';
import 'package:spotify/spotify.dart';

final ui03NotifierProvider = StateNotifierProvider.autoDispose<Ui03Notifier, UI01PageModel>(
  (ref) {
    ref.onDispose(() {
    });
    return Ui03Notifier(ref.read);
  }
);

class Ui03Notifier extends StateNotifier<UI01PageModel> {
  Ui03Notifier(this._reader) : super(UI01PageModel()) {
    Future(() async {
    });
  }

  final Reader _reader;

  late final _prefs = _reader(sharedPreferencesFutureProvider.future);
  late final _log = _reader(debugLogPrintProvider);
  late final _googleApi = _reader(youtubeSearchRepositoryProvider);
  late final _twitterApi = _reader(twitterSearchRepositoryProvider);
  late final _spotifyApi = _reader(spotifySearchRepositoryProvider);
  final String baseUrl = 'https://www.amazon.co.jp';

  scrap() async {
    // Parser? parser = await Chaleno().load('$baseUrl/s?k=splatoon+3&crid=3JESKY1O8LPZ8&sprefix=%2Caps%2C217&ref=nb_sb_ss_recent_1_0_recent');
    String linkUrl = '/%E4%BB%BB%E5%A4%A9%E5%A0%82-%E3%82%B9%E3%83%97%E3%83%A9%E3%83%88%E3%82%A5%E3%83%BC%E3%83%B33-%E3%82%AA%E3%83%B3%E3%83%A9%E3%82%A4%E3%83%B3%E3%82%B3%E3%83%BC%E3%83%89%E7%89%88/dp/B09Y1R9VG4/ref=sr_1_1?crid=3JESKY1O8LPZ8&amp;keywords=splatoon+3&amp;qid=1662647926&amp;sprefix=%2Caps%2C217&amp;sr=8-1';
    Parser? parser = await Chaleno().load(baseUrl + linkUrl);

    if (parser != null) {
      _log.fine(parser.title());

      List<Result> byClassName = parser.getElementsByClassName('a-size-base-plus a-color-base a-text-normal');
      for (final cn in byClassName) {
        _log.fine(cn.text);
      }
      // List<Result> byClassName2 = parser.getElementsByClassName('a-link-normal s-underline-text s-underline-link-text s-link-style a-text-normal');
      // for (final cn in byClassName2) {
      //   _log.fine(cn.href);
      // }
      // #landingImage
      List<Result> byClassName3 = parser.getElementsByClassName('imgTagWrapper');
      for (final cn in byClassName3) {
        _log.fine(cn.innerHTML);
        _log.fine(Parser(cn.innerHTML).children!.first);
      }

      _log.fine('end');
    }
  }

}