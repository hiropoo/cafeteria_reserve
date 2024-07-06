import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/auth/auth_state.dart';
import 'package:sit_in_the_cafeteria/auth/auth_state_notifier.dart';
import 'package:sit_in_the_cafeteria/pages/login_page.dart';
import 'package:sit_in_the_cafeteria/pages/main_page.dart';
import 'package:sit_in_the_cafeteria/pages/sign_up_page.dart';

class BasePage extends ConsumerWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);

    return Scaffold(
      body: authState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stackTrace) {
          debugPrint(e.toString());

          // エラー画面遷移の後にログイン画面に戻す (未実装)
          return const LoginPage();
        },
        data: (authState) {
          debugPrint('authState: $authState');

          // authStateに応じて画面を切り替える
          switch (authState) {
            case AuthState.loggedOut:
              return const LoginPage();
            case AuthState.signUp:
              return const SignUpPage();
            case AuthState.loggedIn:
              return const MainPage();
          }
        },
      ),
    );
  }
}
