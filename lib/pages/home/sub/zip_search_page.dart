import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/notifier/home/sub/zip_notifier.dart';
import 'package:riverpod_app/pages/component/text/text_button_widget.dart';
import 'package:riverpod_app/pages/component/text/text_field_widget.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/route/auto_route_provider.dart';

class ZipSearchPage extends HookConsumerWidget {
  const ZipSearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final log = ref.watch(debugLogPrintProvider);
    final router = ref.watch(autoRouterProvider);

    final state = ref.watch(zipNotifierProvider);
    final notifier = ref.watch(zipNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('zip search'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const Text("郵便番号"),
              TextFieldWidget(controller: notifier.zipCodeController),
              const Gap(20),
              Text(state.zipcode),
              Text(state.address),
              Text(state.addressRead),
              Text(state.errorMessage, style: const TextStyle(color: Colors.red),),
              const Gap(20),
              TextButtonWidget(
                label: '郵便番号で住所検索',
                onTap: () async {
                  log.fine('郵便番号で住所検索をタップ');
                  final result = await notifier.searchWithZipcode();
                  if(result){
                    // OK処理
                    log.fine(result);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
