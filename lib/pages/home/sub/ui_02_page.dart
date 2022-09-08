import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/notifier/home/sub/ui_02_notifier.dart';
import 'package:riverpod_app/pages/component/text/text_button_widget.dart';
import 'package:riverpod_app/pages/component/tweets/spotify_track_page_view.dart';
import 'package:riverpod_app/pages/component/tweets/tweets_page_view.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';

class Ui02Page extends HookConsumerWidget {
  const Ui02Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final log = ref.watch(debugLogPrintProvider);
    final ui02state = ref.watch(ui02NotifierProvider);
    final ui02notifier = ref.watch(ui02NotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('#tuner3'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            TweetsPageView(
              isTweetsOrMedia: ui02state.isTweetsPhotoPriority,
              tweetV2List: ui02state.tweetV2List,
              pageController: ui02notifier.tweetsPageController,
              onPageChanged: (int index) {
                if (ui02notifier.currentTweetsPage > index) {
                  log.finer('${ui02notifier.currentTweetsPage} >  $index');
                  ui02notifier.cancelTimerWithTweetsPage();
                } if (index == 0) {
                  log.finer('${ui02notifier.currentTweetsPage} = $index');
                  ui02notifier.currentTweetsPage = index;
                  ui02notifier.setTimerWithTweetsPage();
                } else {
                  log.finer('${ui02notifier.currentTweetsPage} <= $index');
                  ui02notifier.currentTweetsPage = index;
                  ui02notifier.setTimerWithTweetsPage();
                }
              },
              onTapTweetsUIChange: () {
                log.fine('onTapTweetsUIChange');
                ui02notifier.switchTweetsPhotoPriority();
              },

            ),

            Gap(10),

            TextButtonWidget(
                onTap: () async {
                  log.fine('userLookup');
                  await ui02notifier.userLookup();
                },
                label: 'User Lookup'
            ),

            Gap(10),

            TextButtonWidget(
                onTap: () async {
                  log.fine('tweetLookup');
                  await ui02notifier.tweetLookup();
                },
                label: 'Tweet Lookup'
            ),

            Gap(10),

            SpotifyTrackPageView(
              trackList: ui02state.spotifyTracks,
              pageController: ui02notifier.spotifyPageController,
              onPageChanged: (int index) {
                if (ui02notifier.currentSpotifyPage > index) {
                  log.finer('${ui02notifier.currentSpotifyPage} >  $index');
                  ui02notifier.cancelTimerWithSpotifyPage();
                } if (index == 0) {
                  log.finer('${ui02notifier.currentSpotifyPage} = $index');
                  ui02notifier.currentSpotifyPage = index;
                  ui02notifier.setTimerWithSpotifyPage();
                } else {
                  log.finer('${ui02notifier.currentSpotifyPage} <= $index');
                  ui02notifier.currentSpotifyPage = index;
                  ui02notifier.setTimerWithSpotifyPage();
                }
              },

            ),

            TextButtonWidget(
                onTap: () async {
                  log.fine('spotifyLookup');
                  await ui02notifier.spotifyLookup();
                },
                label: 'Spotify'
            ),

          ],
        ),
      ),
    );
  }
}
