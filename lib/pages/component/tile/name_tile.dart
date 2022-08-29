import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';

class NameTile extends HookConsumerWidget {
  const NameTile({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return Container(
      height: 100,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.emoji_people, size: 90,),
          Flexible(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 25,
                  child: Row(
                    children: const [
                      Text('お名前'),
                      Spacer(),
                      Text('limit 9:00'),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: Text('comment comment comment comment comment comment comment comment comment ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,),
                ),
                Container(
                  height: 25,
                  child: Row(
                    children: [
                      Icon(Icons.android),
                      Gap(10),
                      Icon(Icons.apple),
                      Gap(10),
                      Icon(Icons.desktop_windows),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
