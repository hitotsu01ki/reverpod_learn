import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/component/loading_state_view_model.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';

class LoadingWidget extends HookConsumerWidget {
  const LoadingWidget({Key? key, required this.child,}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final state = ref.watch(loadingNotifierProvider);
    return Stack(children: [
      child,
      state ? Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(theme.appColors.accent),
        ),
      ) : Container(),
    ]);
  }
}
