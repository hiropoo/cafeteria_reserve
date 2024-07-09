import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sit_in_the_cafeteria/components/my_button.dart';
import 'package:sit_in_the_cafeteria/components/my_textfield.dart';
import 'package:sit_in_the_cafeteria/constant/form_category.dart';
import 'package:sit_in_the_cafeteria/pages/sign_up_page.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // コントローラー
    final TextEditingController usernameController = useTextEditingController(); // ユーザー名
    final TextEditingController passwordController = useTextEditingController(); // パスワード

    final formKey = GlobalKey<FormState>();

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
                height: 60,
              ),

              // ログインボタン
              MyButton(
                onPressed: () {
                  // ログイン処理
                  if (formKey.currentState!.validate()) {}
                },
                child: const Text("ログイン"),
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
                      // ログイン画面に遷移
                      Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignUpPage()));
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
