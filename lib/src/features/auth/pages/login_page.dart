import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/components/my_textfield.dart';
import 'package:sit_in_the_cafeteria/src/constant/form_category.dart';
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
            errorMessage.value = "ユーザー名またはパスワードが間違っています。";
            break;
        }
      }
    }

    return Scaffold(
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
                "学食スワローズ",
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
                  data: (_) => const Text('ログイン'),
                  error: (e, _) {
                    errorMessage.value = 'ログインに失敗しました。';
                    return const Text('ログイン');
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
                    "アカウントを持っていない場合",
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      // 新規作成画面に遷移
                      context.push('/${AppRoute.signUp.name}');
                    },
                    child: Text(
                      "新規作成",
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
    );
  }
}
