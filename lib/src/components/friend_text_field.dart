import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';

class FriendTextField extends HookWidget {
  final TextEditingController controller; // コントローラー

  const FriendTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: TextFormField(
        controller: controller,
        style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.secondary),
        // onEditingComplete: () => FocusManager.instance.primaryFocus?.unfocus(),
        onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),

        // テキストフィールドのデザイン
        decoration: InputDecoration(
          labelText: Strings.friendID,
          labelStyle: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.secondary),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceTint,

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
        ),
      ),
    );
  }
}
