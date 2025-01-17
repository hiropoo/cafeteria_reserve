import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyUIFeedbackManager {
  static Future<dynamic> showDialog({
    required BuildContext context,
    required String title,
    required String message,
    required List<Widget> actions,
  }) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: actions,
      ),
    );
  }

  static Future<dynamic> showTextFieldDialog({
    required BuildContext context,
    required String title,
    required String message,
    required TextEditingController controller,
    required List<Widget> actions,
    bool isNumber = false,
  }) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Column(
          children: [
            Text(message),
            const SizedBox(height: 10),
            CupertinoTextField(
              controller: controller,
              placeholder: 'IPアドレス',
              keyboardType: isNumber ? TextInputType.number : TextInputType.url,
              style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: actions,
      ),
    );
  }

  static void showSnackBar({required context, required content}) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          duration: const Duration(milliseconds: 1000),
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: content,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          behavior: SnackBarBehavior.floating,
          showCloseIcon: true,
          elevation: 4.0,
          backgroundColor: Theme.of(context).colorScheme.onSurface,
          clipBehavior: Clip.hardEdge,
        ),
      );
  }
}
