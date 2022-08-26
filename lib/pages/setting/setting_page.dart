import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';

class SettingPage extends HookConsumerWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: SafeArea(
        child: ListView(
          children: const [
            ListTile(leading: Text('Setting 01'), trailing: Icon(Icons.arrow_forward_ios)),
            ListTile(leading: Text('Setting 02'), trailing: Icon(Icons.arrow_forward_ios)),
            ListTile(leading: Text('Setting 03'), trailing: Icon(Icons.arrow_forward_ios)),
            ListTile(leading: Text('Setting 04'), trailing: Icon(Icons.arrow_forward_ios)),
            ListTile(leading: Text('Setting 05'), trailing: Icon(Icons.arrow_forward_ios)),
          ],
        ),
      ),
    );
  }
}
