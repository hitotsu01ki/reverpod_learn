import 'package:auto_route/auto_route.dart';
import 'package:riverpod_app/pages/home/home_page.dart';
import 'package:riverpod_app/pages/home/ui_01_page.dart';
import 'package:riverpod_app/pages/home/ui_02_page.dart';
import 'package:riverpod_app/pages/home/ui_03_page.dart';
import 'package:riverpod_app/pages/home/ui_04_page.dart';
import 'package:riverpod_app/pages/home/zip_search_page.dart';
import 'package:riverpod_app/pages/second/second_page.dart';
import 'package:riverpod_app/pages/navigation/navigation_page.dart';
import 'package:riverpod_app/pages/second/sub/sub_01_page.dart';
import 'package:riverpod_app/pages/setting/setting_page.dart';
import 'package:riverpod_app/pages/signin/sign_in_page.dart';

export 'app_route.gr.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      path: '/',
      page: NavigationPage,
      children: <AutoRoute>[
        AutoRoute(
          path: 'home',
          page: HomePage,
          initial: true,
        ),
        AutoRoute(
          path: 'second',
          page: SecondPage,
        ),
        AutoRoute(
          path: 'setting',
          page: SettingPage,
        ),
      ],
    ),
    AutoRoute(
      path: '/zipSearch',
      page: ZipSearchPage,
    ),
    AutoRoute(
      path: '/sub01page/:label',
      page: Sub01Page,
    ),
    AutoRoute(
      path: '/ui01page',
      page: Ui01Page,
    ),
    AutoRoute(
      path: '/ui02page',
      page: Ui02Page,
    ),
    AutoRoute(
      path: '/ui03page',
      page: Ui03Page,
    ),
    AutoRoute(
      path: '/ui04page',
      page: Ui04Page,
    ),
    AutoRoute(
      path: '/signIn',
      page: SignInPage,
      fullscreenDialog: true,
    ),
  ],
)
class $AppRouter {}
