import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/l10n/l10n.dart';
import 'package:riverpod_app/notifier/home/sub/ui_01_notifier.dart';
import 'package:riverpod_app/pages/component/text/text_button_widget.dart';
import 'package:riverpod_app/pages/component/tweets/tweets_page_view.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Ui01Page extends HookConsumerWidget {
  const Ui01Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final log = ref.watch(debugLogPrintProvider);
    final ui01state = ref.watch(ui01NotifierProvider);
    final ui01notifier = ref.watch(ui01NotifierProvider.notifier);
    final L10n l10n = L10n.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.ui01page),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 200,
              color: Colors.green,
              child: ui01state.liveIds.isEmpty
              ? const Center(child: CircularProgressIndicator()) // ロード中
              : PageView.builder(
                itemCount: ui01state.liveIds.length,
                itemBuilder: (context, index) {
                  return Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1.0,
                          blurRadius: 5.0,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: YoutubePlayer(
                      controller: ui01notifier.youtubePlayerControllerList[index],
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.amber,
                      liveUIColor: Colors.redAccent,
                    ),
                  );
                },
              ),
            ),

            // Container(
            //   height: 240,
            //   margin: const EdgeInsets.symmetric(vertical: 20),
            //   child: PageView.builder(
            //     itemCount: 3,
            //     itemBuilder: (BuildContext context, int index) {
            //       return Container(
            //         clipBehavior: Clip.antiAlias,
            //         margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //         decoration: BoxDecoration(
            //           // color: Colors.greenAccent,
            //           // borderRadius: BorderRadius.circular(20),
            //           boxShadow: [
            //             BoxShadow(
            //               color: Colors.black.withOpacity(0.2),
            //               spreadRadius: 1.0,
            //               blurRadius: 5.0,
            //               // offset: const Offset(5, 5),
            //             ),
            //           ],
            //         ),
            //         child: Column(
            //           children: [
            //             NameTile(),
            //             Gap(10),
            //             NameTile(),
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),

            Gap(10),

            TweetsPageView(
              isTweetsOrMedia: ui01state.isTweetsPhotoPriority,
              tweetV2List: ui01state.tweetV2List,
              pageController: ui01notifier.tweetsPageController,
              onPageChanged: (int index) {
                if (ui01notifier.currentPage > index) {
                  ui01notifier.cancelTweetsTimer();
                } else {
                  ui01notifier.currentPage = index;
                  ui01notifier.setTweetsTimer();
                }
              },
              onTapTweetsUIChange: () {
                log.fine('onTapTweetsUIChange');
                ui01notifier.cancelTweetsTimer();
                ui01notifier.switchTweetsPhotoPriority();
              },
            ),

            Gap(10),

            TextButtonWidget(
              onTap: () async {
                await ui01notifier.searchWithYoutubeLiveIds();
              },
              label: 'Reload Lives'
            ),

            Gap(10),

            TextButtonWidget(
              onTap: () async {
                await ui01notifier.fetchTweets();
              },
              label: 'loadTweet'
            ),

          ],
        ),
      ),
    );
  }
}
