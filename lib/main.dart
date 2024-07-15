import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';
import 'package:sit_in_the_cafeteria/src/utils/theme_notifier.dart';

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider); // テーマの取得
    final goRouter = ref.watch(goRouterProvider); // GoRouterの取得

    return MaterialApp.router(
      theme: theme,
      routerConfig: goRouter,
    );
  }
}
