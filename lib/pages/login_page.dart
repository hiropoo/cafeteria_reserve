import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sit_in_the_cafeteria/components/my_button.dart';
import 'package:sit_in_the_cafeteria/components/my_textfield.dart';
import 'package:sit_in_the_cafeteria/pages/sign_up_page.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // コントローラー
    final TextEditingController usernameController = useTextEditingController(); // ユーザー名
    final TextEditingController passwordController = useTextEditingController(); // パスワード

    return Scaffold(
      body: GestureDetector(
        // 画面をタップでキーボードを閉じる
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        behavior: HitTestBehavior.opaque,

        child: Center(
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
              MyTextfield(controller: usernameController, labelText: 'ユーザー名'),

              const SizedBox(
                height: 30,
              ),

              // パスワード入力欄
              MyTextfield(controller: passwordController, labelText: 'パスワード', isPassword: true),

              const SizedBox(
                height: 60,
              ),

              // ログインボタン
              MyButton(
                onPressed: () {
                  // ログイン処理
                },
                child: const Text("ログイン"),
              ),

              const SizedBox(
                height: 30,
              ),

              // 新規登録ボタン
              MyButton(
                onPressed: () {
                  // 画面遷移
                },
                child: const Text("新規登録"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
