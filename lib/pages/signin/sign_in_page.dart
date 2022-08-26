import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_app/gateway/auth/enum_sign_in.dart';
import 'package:riverpod_app/gen/assets.gen.dart';
import 'package:riverpod_app/notifier/signin/sign_in_notifier.dart';
import 'package:riverpod_app/pages/component/text/text_button_widget.dart';
import 'package:riverpod_app/pages/component/text/text_field_widget.dart';
import 'package:riverpod_app/pages/theme/app_theme.dart';
import 'package:riverpod_app/pages/utils/debug_provider.dart';
import 'package:riverpod_app/route/auto_route_provider.dart';

class SignInPage extends HookConsumerWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeProvider);
    final log = ref.watch(debugLogPrintProvider);
    final router = ref.watch(autoRouterProvider);

    final signInNotifier = ref.watch(signInNotifierProvider.notifier);
    final signInState = ref.watch(signInNotifierProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, ),
          child: Column(
            children: [
              const Gap(16),
              const Text('ログインしてアプリを始めよう',),
              const Gap(16),
              TextFieldWidget(
                hintText: 'Eメール',
                controller: signInNotifier.emailController,
              ),
              const Gap(16),
              TextFieldWidget(
                hintText: 'パスワード',
                controller: signInNotifier.passwordController,
              ),
              /// エラー表示 ///
              signInState.errorMessage != ''
                  ? Text(signInState.errorMessage,)
                  : Container(height: 20,),
              /// エラー表示 ///
              const Gap(16),
              TextButtonWidget(
                label: 'メールアドレスでログイン',
                onTap: () async {
                  log.fine('メールアドレスでログインをタップ');
                  // 追加の処理
                  final result = await signInNotifier.signInWithEmail();
                  if(result){
                    // OK処理
                    log.fine(result);
                    router.pop();
                  }
                },
              ),
              const Gap(12),
              TextButton(
                onPressed: ()  {
                  log.fine('パスワードを忘れた方をタップ');
                  // router.replace = const ResetPasswordRoute();
                },
                child: const Text('パスワードを忘れた方'),
              ),
              const Gap(12),
              TextButtonWidget(
                label: 'LINEでサインイン',
                backgroundColor: Colors.lightGreen,
                onTap: () async {
                  log.fine('LINEでサインインをタップ');
                  signInNotifier.signInType = EnumSignInType.line;
                  final isSuccess = await signInNotifier.signInWithLine();
                  if (isSuccess) {
                    // router.replace = const TermsOfServiceRoute();
                  }
                },
              ),
              const Gap(8),
              TextButtonWidget(
                label: 'Appleでサインイン',
                backgroundColor: Colors.deepOrange,
                onTap: () async {
                  log.fine('Appleでサインインをタップ');
                  signInNotifier.signInType = EnumSignInType.apple;
                  final isSuccess = await signInNotifier.signInWithApple();
                  if (isSuccess) {
                    // router.replace = const TermsOfServiceRoute();
                  }
                },
              ),
              const Gap(8),
              TextButtonWidget(
                label: 'Googleでサインイン',
                backgroundColor: Colors.indigo,
                onTap: () async {
                  log.fine('Googleでサインインをタップ');
                  signInNotifier.signInType = EnumSignInType.google;
                  final isSuccess = await signInNotifier.signInWithGoogle();
                  if (isSuccess) {
                    // router.replace = const TermsOfServiceRoute();
                  }
                },
              ),
              const Gap(8),
              TextButtonWidget(
                label: 'メールアドレスで新規登録',
                backgroundColor: Colors.purple,
                onTap: () async {
                  log.fine('メールアドレスで新規登録をタップ');
                  signInNotifier.signInType = EnumSignInType.email;
                  final isSuccess = await signInNotifier.signUpWithEmail();
                  if (isSuccess) {
                    // router.replace = const TermsOfServiceRoute();
                  }
                },
              ),
              const Gap(8),
              TextButtonWidget(
                label: 'DEBUG：ログインをスキップ',
                backgroundColor: Colors.blueGrey,
                onTap: () async {
                  log.fine('DEBUG：ログインをスキップ');
                  router.pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
