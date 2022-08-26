import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/route/modal_overlay.dart';

final autoRouterProvider = Provider<AutoRouterUtils>((ref) {
  return AutoRouterUtils();
});


class AutoRouterUtils {
  final context = useContext();
  StackRouter get router => context.router;

  // 今のrouteの上に画面遷移
  set pushRoute(PageRouteInfo route) => context.pushRoute(route);

  // 今のrouteの上に画面遷移
  set push(PageRouteInfo route) => context.router.push(route);
  set pushNamed(String path) => context.router.pushNamed(path);

  // 指定のrouteまでpopまたはpushして画面遷移
  set navigate(PageRouteInfo route) => context.router.navigate(route);
  set navigateNamed(String path) => context.router.navigateNamed(path);

  // 今のrouteを入れ替えて画面遷移
  set replace(PageRouteInfo route) => context.router.replace(route);
  set replaceNamed(String path) => context.router.replaceNamed(path);

  // 今のrouteをpop後pushして画面遷移
  set popAndPush(PageRouteInfo route) => context.router.popAndPush(route);

  // 画面を閉じる
  Future<void> pop() => context.router.pop();

  // モーダルでWidgetを表示する
  Future<void> modal(Widget child) async {
    await Navigator.push(
      context,
      ModalOverlay(child),
    );
  }

  // モーダルでWidgetを表示する
  Future<DateTime?> calender(DateTime initialDate) async {
    return await showDatePicker(
        context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
      locale: const Locale("ja"),
    );
  }
}