import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/l10n/l10n.dart';
import 'package:riverpod_app/pages/component/decoration/shadow_container.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:spotify/spotify.dart' as spotify;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SpotifyTrackPageView extends HookConsumerWidget {
  const SpotifyTrackPageView({
    required this.trackList,
    required this.pageController,
    required this.onPageChanged,
    Key? key}) : super(key: key);
  final List<spotify.Track> trackList;
  final PageController pageController;
  final Function(int index) onPageChanged;

  Future<void> _launchUrl(String url) async {
    final _canLaunch = await canLaunchUrlString(url);
    if (_canLaunch) {
      final success = await launch(url);
      print('success :$success $url');
      return;
    }
    final encodedUrl = Uri.encodeFull(url);
    final _canLaunchAgain = await canLaunchUrlString(encodedUrl);
    if (!_canLaunchAgain) {
      print('link launch error $encodedUrl');
      return;
    }
    await launchUrlString(encodedUrl);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final log = ref.watch(debugLogPrintProvider);
    final L10n l10n = L10n.of(context)!;

    List<Widget> tweetsStack(int index) {
      String? imagePath;
      final album = trackList[index].album;
      if (album != null) {
        final images = album.images;
        if (images != null) {
          imagePath = images.first.url;
        }
      }
      imagePath = imagePath ?? '';
      List<Widget> stackList = [];
      stackList.add(Align(
        alignment: Alignment.topLeft,
        child: ShadowContainer(
          margin: const EdgeInsets.only(left: 10, top: 50, bottom: 10, right: 100),
          color: const Color(0xff262626),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap:  () async {
                    log.fine('Open Spotify URL');
                    String path = trackList[index].externalUrls!.spotify!;
                    await _launchUrl(path);
                  },
                  child: Container(
                    width: 250,
                    child: Text(trackList[index].name! + '\n', style: const TextStyle(color: Colors.white), maxLines: 2,),
                  ),
                ),
                Gap(10),
                Container(
                  width: 150,
                  child: Text(trackList[index].album!.artists!.first.name!, style: TextStyle(color: Colors.white), maxLines: 1,),
                ),
                Spacer(),
                Container(
                  height: 50,
                  width: 250,
                  child: WebView(
                    initialUrl: trackList[index].previewUrl,
                    backgroundColor: const Color(0xff262626),
                    // allowsInlineMediaPlayback: true,

                  ),
                ),
              ],
            ),
          ),
        ),
      ));

      if (imagePath != '') {

        stackList.add(Align(
          alignment: Alignment.bottomRight,
          child: ShadowContainer(
            margin: const EdgeInsets.only(left: 100, top: 10, bottom: 40, right: 10),
            color: const Color(0xffe0e0e0),
            child: Container(
              height: 150,
              width: 150,
              child: ListView(
                children: [
                  Image.network(imagePath),
                ],
              ),
            ),
          ),
        ));
      }

      return stackList;
    }

    return Container(
      height: 200,
      color: Colors.blueGrey,
      child: trackList.isEmpty
          ? const Center(child: CircularProgressIndicator()) // ロード中
          : PageView.builder(
        itemCount: trackList.length,
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
