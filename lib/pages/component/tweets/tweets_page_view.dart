import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/l10n/l10n.dart';
import 'package:riverpod_app/pages/component/decoration/shadow_container.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:tweet_ui/models/api/v2/entities/media_v2.dart';
import 'package:tweet_ui/tweet_ui.dart';
import 'package:twitter_api_v2/twitter_api_v2.dart';

class TweetsPageView extends HookConsumerWidget {
  const TweetsPageView({
    required this.tweetV2List,
    required this.pageController,
    required this.onTapTweetsUIChange,
    required this.onPageChanged,
    required this.isTweetsOrMedia,
    Key? key}) : super(key: key);
  final List<TweetV2Response> tweetV2List;
  final PageController pageController;
  final Function() onTapTweetsUIChange;
  final Function(int index) onPageChanged;
  final bool isTweetsOrMedia;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final log = ref.watch(debugLogPrintProvider);
    final L10n l10n = L10n.of(context)!;

    List<Widget> tweetsStack(int index) {

      TweetData? tweetData = TweetData.fromJson(tweetV2List[index].data as Map<String, Object?>);
      TweetAttachments? attachments = tweetData.attachments;
      List<String>? mediaKeys;
      MediaV2? mediaKey;
      if (attachments != null) {
        mediaKeys = attachments.mediaKeys;
        if (mediaKeys != null) {
          for (final media in tweetV2List[index].includes.media) {
            if (mediaKeys.where((element) => element == media.mediaKey).isNotEmpty) {
              mediaKey = media;
            }
          }
        }
      }

      String? imagePath;
      if (mediaKey != null) {
        imagePath = mediaKey.url ?? mediaKey.previewImageUrl;
      }
      imagePath = imagePath ?? '';
      List<Widget> tweetsStackList = [];
      tweetsStackList.add(Align(
        alignment: Alignment.topLeft,
        child: GestureDetector(
          onTap: () {
            log.fine('message');
          },
          child: ShadowContainer(
            margin: const EdgeInsets.only(left: 10, top: 10, bottom: 50, right: 100),
            color: const Color(0xffe0e0e0),
            child: Stack(
              children: [
                ListView(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TweetView.fromTweetV2(
                        tweetV2List[index],
                        backgroundColor: const Color(0xffe0e0e0),
                      ),
                    ),
                  ],
                ),
                // Container(
                //   color: Colors.transparent,
                // ),
              ],
            ),
          ),
        ),
      ));

      // UIを切り替える
      tweetsStackList.add(GestureDetector(
        onTap: onTapTweetsUIChange,
        child: Container(color: Colors.transparent,),
      ));

      if (imagePath != '') {

        tweetsStackList.add(Align(
          alignment: Alignment.bottomRight,
          child: ShadowContainer(
            margin: const EdgeInsets.only(left: 100, top: 50, bottom: 10, right: 10),
            color: const Color(0xffe0e0e0),
            child: ListView(
              children: [
                Image.network(imagePath),
              ],
            ),
          ),
        ));
      }

      if (isTweetsOrMedia) {
        tweetsStackList = tweetsStackList.reversed.toList();
      }

      return tweetsStackList;
    }

    return Container(
      height: 200,
      color: Colors.blueGrey,
      child: tweetV2List.isEmpty
          ? const Center(child: CircularProgressIndicator()) // ロード中
          : PageView.builder(
        itemCount: tweetV2List.length,
        controller: pageController,
        onPageChanged: onPageChanged,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: tweetsStack(index),
          );
        },
      ),
    );
  }
}
