import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/constant/my_theme.dart';

part 'theme_notifier.g.dart';

@riverpod
class Theme extends _$Theme {
  ThemeData themeData = lightTheme; // 使用しているテーマ

  @override
  ThemeData build() {
    return themeData;
  }

  // テーマの切り替え
  void toggleTheme() {
    themeData = themeData == lightTheme ? darkTheme : lightTheme;
  }
}
