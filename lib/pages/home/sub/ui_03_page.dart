import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/notifier/home/sub/ui_03_notifier.dart';
import 'package:riverpod_app/pages/component/text/text_button_widget.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';

class Ui03Page extends HookConsumerWidget {
  const Ui03Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final log = ref.watch(debugLogPrintProvider);
    final ui03state = ref.watch(ui03NotifierProvider);
    final ui03notifier = ref.watch(ui03NotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('#Shopping'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Gap(10),
            TextButtonWidget(
                onTap: () async {
                  log.fine('scrap');
                  await ui03notifier.scrap();
                },
                label: 'Spotify'
            ),
          ],
        ),
      ),
    );
  }
}
