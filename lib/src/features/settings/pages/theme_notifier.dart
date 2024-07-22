import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sit_in_the_cafeteria/src/constant/my_theme.dart';

part 'theme_notifier.g.dart';

@Riverpod(keepAlive: true)
class MyTheme extends _$MyTheme {
  @override
  Future<ThemeData> build() async {
    final prefs = await SharedPreferences.getInstance();
    final theme = prefs.getString('theme') ?? 'light';

    return theme == 'light' ? lightTheme : darkTheme;
  }

  // テーマの切り替え
  void toggleTheme() async {
    // テーマを保存
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('theme', state == AsyncData(lightTheme) ? 'dark' : 'light');

    state = AsyncData(state == AsyncData(lightTheme) ? darkTheme : lightTheme);
  }
}
