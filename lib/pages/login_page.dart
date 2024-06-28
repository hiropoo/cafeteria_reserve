import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sit_in_the_cafeteria/components/my_button.dart';
import 'package:sit_in_the_cafeteria/components/my_textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _usernameController = useTextEditingController(); // ユーザー名
  final TextEditingController _passwordController = useTextEditingController(); // パスワード

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // キーボードが出ても画面がリサイズされない

      body: Center(
        child: GestureDetector(
          // 画面をタップでキーボードを閉じる
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          behavior: HitTestBehavior.opaque,

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

              // ユーザー名入植欄
              MyTextfield(controller: _usernameController, labelText: 'ユーザー名'),

              const SizedBox(
                height: 30,
              ),

              // パスワード入力欄
              MyTextfield(controller: _passwordController, labelText: 'パスワード', isPassword: true),

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
