import 'dart:async';

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

final ui02NotifierProvider = StateNotifierProvider.autoDispose<Ui02Notifier, UI01PageModel>(
  (ref) {
    ref.onDispose(() {
      final tweetsPageTimer = ref.watch(timerProvider2);
      if (tweetsPageTimer.timer != null) {
        if (tweetsPageTimer.timer!.isActive) {
          tweetsPageTimer.disposeTimer();
        }
      }
      final spotifyPageTimer = ref.watch(timerProvider3);
      if (spotifyPageTimer.timer != null) {
        if (spotifyPageTimer.timer!.isActive) {
          spotifyPageTimer.disposeTimer();
        }
      }
    });
    return Ui02Notifier(ref.read);
  }
);

class Ui02Notifier extends StateNotifier<UI01PageModel> implements SpotifyTimer {
  Ui02Notifier(this._reader) : super(UI01PageModel()) {
    Future(() async {
    });
  }

  final Reader _reader;

  late final _prefs = _reader(sharedPreferencesFutureProvider.future);
  late final _log = _reader(debugLogPrintProvider);
  late final _googleApi = _reader(youtubeSearchRepositoryProvider);
  late final _twitterApi = _reader(twitterSearchRepositoryProvider);
  late final _spotifyApi = _reader(spotifySearchRepositoryProvider);
  late final _tweetsPageTimer = _reader(timerProvider2);
  late final _spotifyPageTimer = _reader(timerProvider3);
  // late final _tweetsPageTimer = _reader(timerFamily(tweetsTimer));
  // late final _spotifyPageTimer = _reader(timerFamily(spotifyTimer));

  PageController tweetsPageController = PageController();
  PageController spotifyPageController = PageController();
  int currentTweetsPage = 0;
  int currentSpotifyPage = 0;
  // Timer? tweetsTimer;
  // Timer? spotifyTimer;

  Future<void> userLookup() async {
    final tweets = await _twitterApi.userLookup('hitotsu01ki');
    tweets.when(
        success: (success) {
          linkedTweet(success.id);
        },
        failure: (failure){
          _log.severe(failure.type);
          _log.severe(failure.message);
        }
    );
  }

  Future<void> linkedTweet(String twitterUID) async {
    final tweets = await _twitterApi.tweetLinked(twitterUID);
    tweets.when(
        success: (success) {
          state = state.copyWith(tweetV2List: success);
          setTimerWithTweetsPage();
        },
        failure: (failure) {
          _log.severe(failure.type);
          _log.severe(failure.message);
        }
    );
  }

  Future<void> tweetLookup() async {
    final tweets = await _twitterApi.tweetLookupById('1564774331896709121');
    tweets.when(
        success: (success) {
          _log.fine(success.text);
        },
        failure: (failure) {
          _log.severe(failure.type);
          _log.severe(failure.message);
        }
    );
  }

  void switchTweetsPhotoPriority() {
    state = state.copyWith(isTweetsPhotoPriority: !state.isTweetsPhotoPriority);
  }

  void setTimerWithTweetsPage() {
    _tweetsPageTimer.addTimerListener((timer) async {
      if (currentTweetsPage < state.tweetV2List.length - 1) {
        currentTweetsPage++;
      } else {
        currentTweetsPage = 0;
      }

      await tweetsPageController.animateToPage(
        currentTweetsPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }, const Duration(seconds: 4));
  }

  void cancelTimerWithTweetsPage() {
    _tweetsPageTimer.disposeTimer();
  }

  Future<void> spotifyLookup() async {
    final trackSearch = await _spotifyApi.trackSearch('');
    trackSearch.when(
        success: (success) {
          state = state.copyWith(spotifyTracks: success);
          setTimerWithSpotifyPage();
        },
        failure: (failure) {
          _log.severe(failure.type);
          _log.severe(failure.message);
        }
    );
  }

  @override
  void setTimerWithSpotifyPage() {
    _spotifyPageTimer.addTimerListener((timer) async {
      if (currentSpotifyPage < state.spotifyTracks.length - 1) {
        currentSpotifyPage++;
      } else {
        currentSpotifyPage = 0;
      }

      await spotifyPageController.animateToPage(
        currentSpotifyPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.linear,
      );
    }, const Duration(seconds: 30));
  }

  @override
  void cancelTimerWithSpotifyPage() {
    _spotifyPageTimer.disposeTimer();
  }

}