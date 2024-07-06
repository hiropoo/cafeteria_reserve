import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/notifiers/theme_notifier.dart';
import 'package:sit_in_the_cafeteria/pages/base_page.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider); // テーマの取得

    return MaterialApp(
      theme: theme,
      home: const BasePage(),
    );
  }
}
