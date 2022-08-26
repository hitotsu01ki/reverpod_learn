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
      appBar: AppBar(title: Text('Home')),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: Text('住所検索APIサンプル'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('住所検索APIサンプル');
                router.push = const ZipSearchRoute();
              },
            ),
            ListTile(
              leading: Text('UI Text 01'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('UI Text 01');
                router.push = const Ui01Route();
              },
            ),
            ListTile(
              leading: Text('UI Text 02'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('UI Text 02');
                router.push = const Ui02Route();
              },
            ),
            ListTile(
              leading: Text('UI Text 03'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('UI Text 03');
                router.push = const Ui03Route();
              },
            ),
            ListTile(
              leading: Text('UI Text 04'),
              trailing: Icon(Icons.arrow_forward_ios),
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
