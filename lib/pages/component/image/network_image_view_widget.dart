import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';

class NetworkImageViewWidget extends HookConsumerWidget {
  const NetworkImageViewWidget(this.imageUrl, {this.imageLabel = 'No imageLabel', this.imageHeight = 60, this.imageWidth = 60,  Key? key}) : super(key: key);
  final String imageUrl;
  final String imageLabel;
  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final log = ref.watch(debugLogPrintProvider);

    return imageUrl != '' ? CachedNetworkImage(
      imageUrl: imageUrl,
      width: imageHeight,
      height: imageWidth,
      progressIndicatorBuilder: (context, url, downloadProgress) {
        return CircularProgressIndicator(value: downloadProgress.progress);
      },
      errorWidget: (context, url, error) {
        // log.severe('[$imageLabel]$error');
        return const Icon(Icons.error, color: Colors.red,);
      },
    ) : Container();
  }
}
