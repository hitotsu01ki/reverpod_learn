import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';

class TextButtonWidget extends HookConsumerWidget {
  const TextButtonWidget({
    required this.onTap,
    required this.label,
    this.height = 40,
    this.width = 200,
    this.backgroundColor = Colors.indigoAccent,
    this.textFontColor = Colors.white,
    Key? key
  }) : super(key: key);
  final Function() onTap;
  final String label;
  final double height;
  final double width;
  final Color backgroundColor;
  final Color textFontColor;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        height: height,
        width: width,
        child: Center(child: Text(label, style: TextStyle(color: textFontColor, fontWeight: FontWeight.bold))),
      ),
    );
  }
}
