import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';

class Ui03Page extends HookConsumerWidget {
  const Ui03Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: const [
            Center(
              child: Text('Ui03Route'),
            ),
          ],
        ),
      ),
    );
  }
}
