import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/route/app_route.gr.dart';
import 'package:riverpod_app/route/auto_route_provider.dart';

class SecondPage extends HookConsumerWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final router = ref.watch(autoRouterProvider);
    final log = ref.watch(debugLogPrintProvider);

    return Scaffold(
      appBar: AppBar(title: Text('AutoRouter')),
      body: SafeArea(
        child: ListView(
          children: [
            ListTile(
              leading: Text('Page 01 pushRoute'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('pushRoute');
                router.pushRoute = Sub01Route(label: 'pushRoute');
              },
            ),
            ListTile(
              leading: Text('Page 02 push'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('push');
                router.push = Sub01Route(label: 'push');
              },
            ),
            ListTile(
              leading: Text('Page 03 navigate'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('navigate');
                router.navigate = Sub01Route(label: 'navigate');
              },
            ),
            ListTile(
              leading: Text('Page 04 popAndPush'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('popAndPush');
                router.popAndPush = Sub01Route(label: 'popAndPush');
              },
            ),
            ListTile(
              leading: Text('Page 05 replace'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                log.fine('replace');
                // router.replace = Sub01Route(label: 'replace');
              },
            ),
          ],
        ),
      ),
    );
  }
}
