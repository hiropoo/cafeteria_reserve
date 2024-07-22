import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/domains/auth_state.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/auth_state_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/login_page.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/sign_up_page.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';

class AuthBasePage extends ConsumerWidget {
  const AuthBasePage({super.key});

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
              WidgetsBinding.instance.addPostFrameCallback((_) {
                context.pushReplacementNamed(AppRoute.location.name);
              });
              break;
            case AuthState.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('エラーが発生しました'),
                    const SizedBox(height: 30),
                    MyButton(
                      onPressed: () => context.goNamed(AppRoute.login.name),
                      child: const Text('戻る'),
                    ),
                  ],
                ),
              );
          }
          return null;
        },
      ),
    );
  }
}
