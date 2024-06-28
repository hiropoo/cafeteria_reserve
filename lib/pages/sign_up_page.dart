import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sit_in_the_cafeteria/components/my_button.dart';
import 'package:sit_in_the_cafeteria/components/my_textfield.dart';
import 'package:sit_in_the_cafeteria/pages/login_page.dart';

class SignUpPage extends HookWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    // コントローラー
    final TextEditingController usernameController = useTextEditingController(); // ユーザー名
    final TextEditingController studentIDController = useTextEditingController(); // 学籍番号
    final TextEditingController passwordController = useTextEditingController(); // パスワード
    final TextEditingController confirmPasswordController = useTextEditingController(); // 確認用パスワード

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
                height: 25,
              ),

              // ユーザー名入力欄
              MyTextfield(controller: usernameController, labelText: 'ユーザー名'),

              const SizedBox(
                height: 15,
              ),

              // 学籍番号入力欄
              MyTextfield(controller: studentIDController, labelText: '学籍番号'),

              const SizedBox(
                height: 15,
              ),

              // パスワード入力欄
              MyTextfield(controller: passwordController, labelText: 'パスワード', isPassword: true),

              const SizedBox(
                height: 15,
              ),

              // 確認パスワード入力欄
              MyTextfield(controller: confirmPasswordController, labelText: 'パスワード (確認用)', isPassword: true),

              const SizedBox(
                height: 60,
              ),

              // 新規登録ボタン
              MyButton(
                onPressed: () {
                  // 新規登録処理

                  // 画面遷移
                },
                child: const Text("新規登録"),
              ),

              const SizedBox(
                height: 15,
              ),

              // アカウントを既に持っている場合のログイン画面への遷移ボタン
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "すでにアカウントをお持ちの方",
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
                      // ログイン画面に遷移
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage()));
                    },
                    child: Text(
                      "ログイン",
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
