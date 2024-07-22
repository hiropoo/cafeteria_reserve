import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/components/my_textfield.dart';
import 'package:sit_in_the_cafeteria/src/constant/form_category.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/domains/auth_state.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/auth_state_notifier.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // コントローラー
    final TextEditingController usernameController = useTextEditingController(); // ユーザー名
    final TextEditingController passwordController = useTextEditingController(); // パスワード

    // Validation用のフォームキー
    final formKey = GlobalKey<FormState>();

    // エラーメッセージ
    final errorMessage = useState<String>(" ");

    // AuthState
    final authState = ref.watch(authStateNotifierProvider);

    // ログイン処理
    Future login() async {
      if (formKey.currentState!.validate()) {
        final username = usernameController.text;
        final password = passwordController.text;

        final authStateNotifier = ref.read(authStateNotifierProvider.notifier);

        final bool result = await authStateNotifier.login(userName: username, password: password);

        switch (result) {
          // ログイン成功 -> メインページに遷移
          case true:
            if (context.mounted) context.pushReplacementNamed(AppRoute.location.name);
            break;

          // ログイン失敗 -> エラーメッセージを表示
          case false:
            switch (authState.asData?.value) {
              case AuthState.loggedOut:
                errorMessage.value = Strings.loginFailed;
                break;
              case AuthState.error:
                errorMessage.value = Strings.errorOccurred;
                break;
              default:
            }
            break;
        }
      }
    }

    final longPressTimer = useState<Timer?>(null);

    void startLongPressTimer() {
      debugPrint('startLongPressTimer');
      longPressTimer.value = Timer(const Duration(seconds: 5), () {
        // 5秒経過した後に画面遷移を行う
        context.pushNamed(AppRoute.network.name);
      });
    }

    // 長押し終了時の処理
    void cancelLongPressTimer() {
      longPressTimer.value?.cancel();
      longPressTimer.value = null;
    }

    return PopScope(
      canPop: false, // ログイン画面から戻ることを禁止

      child: Scaffold(
        body: Center(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                // タイトル
                Text(
                  Strings.appName,
                  style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),

                const SizedBox(
                  height: 45,
                ),

                // ユーザー名入力欄
                MyTextFormField(
                  controller: usernameController,
                  formCategory: FormCategory.username,
                ),

                const SizedBox(
                  height: 30,
                ),

                // パスワード入力欄
                MyTextFormField(
                  controller: passwordController,
                  isPassword: true,
                  formCategory: FormCategory.password,
                ),

                const SizedBox(
                  height: 20,
                ),

                // エラーメッセージ表示部分
                if (errorMessage.value.isNotEmpty)
                  Text(
                    errorMessage.value,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),

                const SizedBox(
                  height: 20,
                ),

                // ログインボタン
                MyButton(
                  onPressed: login,
                  child: authState.when(
                    data: (_) => const Text(Strings.login),
                    error: (e, _) {
                      errorMessage.value = Strings.loginFailed;
                      return const Text(Strings.login);
                    },
                    loading: () => const CircularProgressIndicator(),
                  ),
                ),

                const SizedBox(
                  height: 30,
                ),

                // アカウントを作成する場合の新規登録画面への遷移ボタン
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Strings.noAccount,
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    GestureDetector(
                      onLongPress: startLongPressTimer,
                      onLongPressEnd: (details) {
                        cancelLongPressTimer();
                      },
                      onTap: () {
                        // 新規作成画面に遷移
                        context.goNamed(AppRoute.signUp.name);
                      },
                      child: Text(
                        Strings.signUp,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
