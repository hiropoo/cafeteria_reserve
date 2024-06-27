import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MyTextfield extends HookWidget {
  final TextEditingController controller; // コントローラー
  final String labelText; // ラベル
  final bool isPassword; // パスワードかどうか

  const MyTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    this.isPassword = false,
  });

  @override
  Widget build(BuildContext context) {
    final isObscure = useState(true); // 目のマークの表示非表示

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 35),
      child: TextField(
        controller: controller,
        obscureText: isPassword && isObscure.value,
        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.secondary),

        // テキストフィールドのデザイン
        decoration: InputDecoration(
          labelText: labelText,
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
