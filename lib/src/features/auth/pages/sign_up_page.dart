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
import 'package:sit_in_the_cafeteria/src/utils/my_ui_feedback_manager.dart';

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // コントローラー
    final TextEditingController usernameController = useTextEditingController(); // ユーザー名
    final TextEditingController studentIDController = useTextEditingController(); // 学籍番号
    final TextEditingController passwordController = useTextEditingController(); // パスワード
    final TextEditingController confirmPasswordController = useTextEditingController(); // 確認用パスワード

    // エラーメッセージ
    final errorMessage = useState<String>(" ");

    // AuthState
    final authState = ref.watch(authStateNotifierProvider);

    // Validation用のフォームキー
    final formKey = GlobalKey<FormState>();

    // 新規登録処理
    Future signUp() async {
      if (formKey.currentState!.validate()) {
        // 新規登録処理
        final username = usernameController.text;
        final password = passwordController.text;
        final studentID = studentIDController.text;

        final authStateNotifier = ref.read(authStateNotifierProvider.notifier);

        final result = await authStateNotifier.signUp(
          userName: username,
          password: password,
          studentID: int.parse(studentID),
        );

        // 画面遷移
        switch (result) {
          // 新規登録成功 -> ポップアップを表示 -> ログイン画面に遷移
          case true:
            if (context.mounted) {
              errorMessage.value = '';
              MyUIFeedbackManager.showDialog(context: context, title: Strings.signUpCompleted, message: Strings.signUpCompletedMessage, actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.pushReplacementNamed(AppRoute.login.name);
                  },
                  child: const Text(Strings.dialogConfirm),
                ),
              ]);
            }
            break;

          // ログイン失敗 -> エラーメッセージを表示
          case false:
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
    }

    return PopScope(
      canPop: false, // 新規登録画面から戻ることを禁止

      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(top: 200, bottom: 20),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Center(
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
                    height: 25,
                  ),

                  // ユーザー名入力欄
                  MyTextFormField(
                    controller: usernameController,
                    formCategory: FormCategory.username,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // 学籍番号入力欄
                  MyTextFormField(
                    controller: studentIDController,
                    formCategory: FormCategory.studentID,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // パスワード入力欄
                  MyTextFormField(
                    controller: passwordController,
                    isPassword: true,
                    formCategory: FormCategory.password,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  // 確認パスワード入力欄
                  MyTextFormField(
                    controller: confirmPasswordController,
                    isPassword: true,
                    formCategory: FormCategory.confirmPassword,
                    passwordController: passwordController,
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

                  // 新規登録ボタン
                  MyButton(
                    onPressed: signUp,
                    child: authState.when(
                      data: (_) => const Text(Strings.signUp),
                      error: (e, _) {
                        errorMessage.value = Strings.signUpFailed;
                        return const Text(Strings.signUp);
                      },
                      loading: () => const CircularProgressIndicator(),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),

                  // アカウントを既に持っている場合のログイン画面への遷移ボタン
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.alreadyHaveAccount,
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
                          context.goNamed(AppRoute.login.name);
                        },
                        child: Text(
                          Strings.login,
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
      ),
    );
  }
}
