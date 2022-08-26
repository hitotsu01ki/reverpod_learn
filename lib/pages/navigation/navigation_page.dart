import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gen/assets.gen.dart';
import 'package:riverpod_app/route/app_route.gr.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';

class NavigationPage extends HookConsumerWidget {
  const NavigationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        SecondRoute(),
        SettingRoute(),
      ],
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.login),
        onPressed: () {
          AutoRouter.of(context).push(const SignInRoute());
        },
      ),
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: tabsRouter.setActiveIndex,
          iconSize: 20,
          items: [
            BottomNavigationBarItem(
              icon: Assets.images.debug.png250x250.image(
                width: 20,
                color: tabsRouter.current.name == HomeRoute.name
                    ? theme.appColors.accent
                    : theme.appColors.disabled,
              ),
              label: 'home',
            ),
            BottomNavigationBarItem(
              icon: Assets.images.debug.png250x250.image(
                width: 20,
                color: tabsRouter.current.name == SecondRoute.name
                    ? theme.appColors.accent
                    : theme.appColors.disabled,
              ),
              label: 'second',
            ),
            BottomNavigationBarItem(
              icon: Assets.images.debug.png250x250.image(
                width: 20,
                color: tabsRouter.current.name == SettingRoute.name
                    ? theme.appColors.accent
                    : theme.appColors.disabled,
              ),
              label: 'setting',
            ),
          ],
        );
      },
    );
  }
}
