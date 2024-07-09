import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sit_in_the_cafeteria/src/constant/form_category.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/utils/string_extensions.dart';

class MyTextFormField extends HookWidget {
  final TextEditingController controller; // コントローラー
  final TextEditingController? passwordController; // パスワードのコントローラー (確認用)
  final bool isPassword; // パスワードかどうか
  final FormCategory formCategory; // フォームのカテゴリー

  const MyTextFormField({
    super.key,
    required this.controller,
    this.passwordController,
    required this.formCategory,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final isObscure = useState(true); // 目のマークの表示非表示

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword && isObscure.value,
        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.secondary),
        onEditingComplete: () => FocusManager.instance.primaryFocus?.unfocus(),
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),

        validator: (value) {
          switch (formCategory) {
            case FormCategory.username:
              if (value == null || value.isEmpty) {
                return Strings.usernameEmpty;
              } else if (value.contains(" ") || value.contains("　")) {
                return Strings.usernameSpace;
              } else if (!value.isValidAlphanumeric()) {
                return Strings.usernameNotAlphanumeric;
              }
              break;

            case FormCategory.password:
              if (value == null || value.isEmpty) {
                return Strings.passwordEmpty;
              } else if (value.contains(" ") || value.contains("　")) {
                return Strings.passwordSpace;
              }
              break;

            case FormCategory.studentID:
              if (value == null || value.isEmpty) {
                return Strings.studentIDEmpty;
              } else if (value.contains(" ") || value.contains("　")) {
                return Strings.studentIDSpace;
              }
              break;

            case FormCategory.confirmPassword:
              if (value == null || value.isEmpty) {
                return Strings.confirmPasswordEmpty;
              } else if (value.contains(" ") || value.contains("　")) {
                return Strings.passwordSpace;
              } else if (value != passwordController!.text) {
                return 'パスワードが一致しません';
              }
              break;
          }
          return null;
        },

        // テキストフィールドのデザイン
        decoration: InputDecoration(
          labelText: switch (formCategory) {
            FormCategory.username => Strings.username,
            FormCategory.password => Strings.password,
            FormCategory.studentID => Strings.studentID,
            FormCategory.confirmPassword => Strings.confirmPassword,
          },
          labelStyle: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.secondary),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,

          // 通常時のデザイン
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),

          // フォーカス時のデザイン
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),

          // 目のマーク
          suffixIcon: isPassword
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: IconButton(
                    icon: Icon(isObscure.value ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      isObscure.value = !isObscure.value;
                    },
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
