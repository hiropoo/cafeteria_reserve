import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/constant/my_theme.dart';
import 'package:sit_in_the_cafeteria/src/features/settings/pages/theme_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/settings/pages/use_mobile_theme.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // MyThemeの初期化
  final container = ProviderContainer();
  await container.read(myThemeProvider.future);
  await container.read(useMobileThemeProvider.future);

  runApp(UncontrolledProviderScope(
    container: container,
    child: const MainApp(),
  ));
}

class MainApp extends HookConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(myThemeProvider).asData?.value ?? lightTheme; // テーマの取得
    final useMobileTheme = ref.watch(useMobileThemeProvider).asData?.value ?? false; // モバイルテーマの取得
    final goRouter = ref.watch(goRouterProvider); // GoRouterの取得

    final mobileTheme = MediaQuery.platformBrightnessOf(context) == Brightness.dark ? darkTheme : lightTheme;

    return MaterialApp.router(
      theme: useMobileTheme ? mobileTheme : theme,
      routerConfig: goRouter,
    );
  }
}
