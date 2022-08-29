import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/repository/twitter/twitter_search_repository_impl.dart';
import 'package:riverpod_app/gateway/repository/youtube/youtube_search_repository_impl.dart';
import 'package:riverpod_app/model/home/sub/ui_01_page_model.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/pages/utils/shared_preferences_provider.dart';
import 'package:riverpod_app/pages/utils/timer_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

final ui01NotifierProvider = StateNotifierProvider.autoDispose<Ui01Notifier, UI01PageModel>(
  (ref) {
    ref.onDispose(() {
      final timer = ref.watch(timerProvider);
      timer.disposeTimer();
    });
    return Ui01Notifier(ref.read);
  }
);

class Ui01Notifier extends StateNotifier<UI01PageModel> {
  Ui01Notifier(this._reader) : super(UI01PageModel()) {
    Future(() async {
      await searchWithYoutubeLiveIds();
      await fetchTweets();
    });
  }

  final Reader _reader;

  late final _prefs = _reader(sharedPreferencesFutureProvider.future);
  late final _log = _reader(debugLogPrintProvider);
  late final _googleApi = _reader(youtubeSearchRepositoryProvider);
  late final _twitterApi = _reader(twitterSearchRepositoryProvider);
  late final _timer = _reader(timerProvider);

  List<YoutubePlayerController> youtubePlayerControllerList = [];
  PageController tweetsPageController = PageController();
  int currentPage = 0;

  Future<bool> searchWithYoutubeLiveIds() async {

    final result = await _googleApi.youtubeLiveSearch('Flutter');
    return result.when(
      success: (success) {
        final ids = success.map((e) => e.id!.videoId).toList();
        ids.shuffle();
        state = state.copyWith(liveIds: ids);
        fetchYoutubeLives();
        return true;
      },
      failure: (failure) {
        _log.severe(failure.type);
        _log.severe(failure.message);
        return false;
      },
    );
  }

  fetchYoutubeLives() {
    youtubePlayerControllerList.addAll(
        state.liveIds.map((id) => YoutubePlayerController(
        initialVideoId: id,
        flags: const YoutubePlayerFlags(
          mute: true,
          isLive: true,
          autoPlay: false,
          showLiveFullscreenButton: false,
        ),
      )),
    );
  }

  Future<void> fetchTweets() async {
    final tweets = await _twitterApi.tweetSearch('#Flutter -is:retweet -is:reply');
    tweets.when(
      success: (success) {
        state = state.copyWith(tweetV2List: success);
        setTweetsTimer();
      },
      failure: (failure){
        _log.severe(failure.type);
        _log.severe(failure.message);
      }
    );
  }

  void cancelTweetsTimer() {
    _timer.disposeTimer();
  }

  void setTweetsTimer() {
    if (_timer.timer != null) {
      if (_timer.timer!.isActive) {
        return;
      }
    }
    _timer.setTimer = Timer.periodic(
      const Duration(seconds: 3),
          (timer) async {
        if (currentPage < state.tweetV2List.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }

        await tweetsPageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 200),
          curve: Curves.linear,
        );
      },
    );

  }

  switchTweetsPhotoPriority() {
    state = state.copyWith(isTweetsPhotoPriority: !state.isTweetsPhotoPriority);
  }


}