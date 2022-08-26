import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';

class TextFieldWidget extends HookConsumerWidget {
  const TextFieldWidget({
    required this.controller,
    this.focusNode,
    this.hintText = '',
    this.padding = EdgeInsets.zero,
    Key? key
  }) : super(key: key);
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final EdgeInsets padding;
  final String hintText;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);

    return Padding(
      padding: padding,
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hintText,
        ),
      ),
    );
  }
}
