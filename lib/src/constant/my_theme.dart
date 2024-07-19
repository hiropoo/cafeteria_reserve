import 'package:flutter/material.dart';

// ライトテーマ
ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
      surface: Color(0xFFF4F4F4), // 領域
      onSurface: Color(0xFF817F7F), // 領域の上の領域
      primary: Color(0xFF70C1CC), // メインカラー
      secondary: Color(0xFF3D3D3D), // ボタン
      tertiary: Color(0xFF81D762), // アクセント
      inversePrimary: Color(0xFFF4F4F4)),
);

// ダークテーマ (未定義)
ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFFF4F4F4), // 領域
    onSurface: Color(0xFFD9D9D9), // 領域の上の領域
    primary: Color(0xFF70C1CC), // メインカラー
    secondary: Color(0xFF3D3D3D), // ボタン
    tertiary: Color(0xFF81D762), // アクセント
  ),
);
