import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/component/text/text_button_widget.dart';
import 'package:riverpod_app/pages/component/text/text_field_widget.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/utils_provider.dart';
import 'package:riverpod_app/route/app_route.gr.dart';
import 'package:riverpod_app/route/auto_route_provider.dart';

class Sub01Page extends HookConsumerWidget {
  const Sub01Page(@PathParam('label') this.label, {Key? key}) : super(key: key);
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final utils = ref.watch(utilsProvider);
    final router = ref.watch(autoRouterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Route Type')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Center(
            child: Column(
              children: [
                const Gap(40),
                Text(label, style: const TextStyle(fontSize: 32)),
                const Gap(40),
                TextButtonWidget(
                  label: 'Back',
                  onTap: () {
                    router.pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
