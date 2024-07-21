import 'package:flutter/cupertino.dart';

class MyDialog {
  static Future<dynamic> show({
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
}
