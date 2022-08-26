import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/utils_provider.dart';

class ModalContainer extends HookConsumerWidget {
  const ModalContainer({
    required this.child,
    Key? key
  }) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final utils = ref.watch(utilsProvider);

    return Container(
      height: utils.size.height / 10 * 7,
      width: utils.size.width / 10 * 8,
      color: const Color(0xfffcfcfc),
      child: child
    );
  }
}
