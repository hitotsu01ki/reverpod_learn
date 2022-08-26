import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';

class FileImageViewWidget extends HookConsumerWidget {
  const FileImageViewWidget(this.imageFile, {this.imageLabel = 'No imageLabel', this.imageHeight = 60, this.imageWidth = 60,  Key? key}) : super(key: key);
  final File imageFile;
  final String imageLabel;
  final double imageHeight;
  final double imageWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final log = ref.watch(debugLogPrintProvider);

    return Image.file(
      imageFile,
      width: imageHeight,
      height: imageWidth,
      errorBuilder: (context, url, error) {
        // log.severe('[$imageLabel]$error');
        return const Icon(Icons.error, color: Colors.red,);
      },
    );
  }
}
