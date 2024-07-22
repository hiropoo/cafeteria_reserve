import 'package:flutter/material.dart';

// ライトテーマ
ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Color(0xFFF4F4F4), // 領域
    onSurface: Color(0xFF817F7F), // 領域の上の領域
    primary: Color(0xFF70C1CC), // メインカラー
    secondary: Color(0xFF3D3D3D), // ボタン
    tertiary: Color(0xFF81D762), // アクセント
    inversePrimary: Color(0xFFF4F4F4),
    surfaceTint: Color(0xFFFFFFFF), // フレンドテキストフィールド
  ),
);

// ダークテーマ (未定義)
ThemeData darkTheme = ThemeData(
  colorScheme: const ColorScheme.dark(
    surface: Color(0xFF1E1E1E), // 領域
    onSurface: Color(0xFFE0E0E0), // 領域の上の領域
    primary: Color(0xFF70C1CC), // メインカラー
    secondary: Color.fromARGB(255, 211, 211, 211), // ボタン
    tertiary: Color(0xFF81D762), // アクセント
    inversePrimary: Color(0xFF1E1E1E), // 逆のメインカラー
    surfaceTint: Color.fromARGB(255, 0, 0, 0), // フレンドテキストフィールド
  ),
);
