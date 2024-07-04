import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/auth/auth_state.dart';
import 'package:sit_in_the_cafeteria/auth/auth_state_notifier.dart';
import 'package:sit_in_the_cafeteria/notifiers/user_notifier.dart';
import 'package:sit_in_the_cafeteria/pages/login_page.dart';
import 'package:sit_in_the_cafeteria/pages/main_page.dart';
import 'package:sit_in_the_cafeteria/pages/sign_up_page.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ログイン状態を取得
    final authState = ref.watch(authStateNotifierProvider);

    return Scaffold(
      // ログイン状態によって表示を変える
      body: authState.when(
        // データ取得中
        loading: () => const Center(child: CircularProgressIndicator()),

        // エラー時はログイン画面に遷移
        error: (e, stackTrace) {
          debugPrint(e.toString());
          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage()));
          return null;
        },
        data: (authState) {
          debugPrint('authState: $authState');

          // ログイン状態によって画面を切り替える
          switch (authState) {
            // 前回ログアウトしている場合は、ログイン画面を表示
            case AuthState.loggedOut:
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage()));

            // 新規登録画面を表示
            case AuthState.signUp:
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignUpPage()));

            // 自動でログインしてホーム画面を表示
            case AuthState.loggedIn:
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MainPage()));
            default:
              Text('unknown authState: $authState');
          }
        },
      ),
    );
  }
}
