// ElevatedButton　のデザインを再利用するために、MyButton　というコンポーネントを作成
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget child; // CircularProgressIndicatorを表示するためにWidget型を指定

  const MyButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,

        // ボタンのデザイン
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          textStyle: const TextStyle(fontSize: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),

        // ボタンの中身
        child: child,
      ),
    );
  }
}
