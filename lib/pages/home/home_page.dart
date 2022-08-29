import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/route/app_route.dart';
import 'package:riverpod_app/route/auto_route_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final router = ref.watch(autoRouterProvider);
    final log = ref.watch(debugLogPrintProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: const Text('住所検索APIサンプル'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('住所検索APIサンプル');
                router.push = const ZipSearchRoute();
              },
            ),
            ListTile(
              leading: const Text('Live Streaming'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('Live Streaming');
                router.push = const Ui01Route();
              },
            ),
            ListTile(
              leading: const Text('UI Text 02'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('UI Text 02');
                router.push = const Ui02Route();
              },
            ),
            ListTile(
              leading: const Text('UI Text 03'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('UI Text 03');
                router.push = const Ui03Route();
              },
            ),
            ListTile(
              leading: const Text('UI Text 04'),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('UI Text 04');
                router.push = const Ui04Route();
              },
            ),
          ],
        ),
      ),
    );
  }
}
