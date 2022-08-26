import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';

class Sub02Page extends HookConsumerWidget {
  const Sub02Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Text('Sub02Route'),
        ),
      ),
    );
  }
}
