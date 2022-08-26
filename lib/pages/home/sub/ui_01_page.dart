import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';

class Ui01Page extends HookConsumerWidget {
  const Ui01Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ui01Route'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 200,
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: List.generate(5, (index) => Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.cyanAccent,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1.0,
                          blurRadius: 5.0,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    height: 200,
                    width: 300,
                    child: Center(child: Text('card $index')),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
