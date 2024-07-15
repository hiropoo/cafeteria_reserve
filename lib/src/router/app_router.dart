import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/auth_base_page.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/login_page.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/sign_up_page.dart';
import 'package:sit_in_the_cafeteria/src/main_page.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  base,
  signUp,
  login,
  main,
  reservation,
  location,
  profile,
}

@riverpod
GoRouter goRouter(GoRouterRef ref) {
  return GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/',
        name: AppRoute.base.name,
        pageBuilder: (context, state) => const MaterialPage(child: AuthBasePage()),
        routes: [
          GoRoute(
            path: 'login',
            name: AppRoute.login.name,
            pageBuilder: (context, state) => const MaterialPage(child: LoginPage()),
          ),
          GoRoute(
            path: 'signUp',
            name: AppRoute.signUp.name,
            pageBuilder: (context, state) => const MaterialPage(child: SignUpPage()),
          ),
          GoRoute(
            path: 'main',
            name: AppRoute.main.name,
            pageBuilder: (context, state) => const MaterialPage(child: MainPage()),
          ),
        ],
      )
    ],
  );
}
