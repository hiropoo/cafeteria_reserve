import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/auth_base_page.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/login_page.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/sign_up_page.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/location_base_page.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/result_page/send_result_page.dart';
import 'package:sit_in_the_cafeteria/src/features/profile/pages/my_page.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_page.dart';
import 'package:sit_in_the_cafeteria/src/main_page.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _locationNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'location');

enum AppRoute {
  base,
  signUp,
  login,
  reservation,
  location,
  sendResult,
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

          // アプリのフレーム。永続化したbottomNavigationBarとDrawerを持つ
          StatefulShellRoute.indexedStack(
            parentNavigatorKey: _rootNavigatorKey,
            pageBuilder: (context, state, shellWidget) => MaterialPage(
                child: MainPage(
              child: shellWidget,
            )),
            branches: [
              StatefulShellBranch(
                navigatorKey: _locationNavigatorKey,
                routes: [
                  GoRoute(
                    path: 'reservation',
                    name: AppRoute.reservation.name,
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: Center(child: ReservationPage()),
                    ),
                  ),
                  GoRoute(
                      path: 'location',
                      name: AppRoute.location.name,
                      pageBuilder: (context, state) => const NoTransitionPage(
                            child: Center(child: LocationBasePage()),
                          ),
                      routes: [
                        GoRoute(
                          path: 'sendResult',
                          name: AppRoute.sendResult.name,
                          pageBuilder: (context, state) => const NoTransitionPage(
                            child: Center(child: SendResultPage()),
                          ),
                        ),
                      ]),
                  GoRoute(
                    path: 'profile',
                    name: AppRoute.profile.name,
                    pageBuilder: (context, state) => const NoTransitionPage(
                      child: Center(child: MyPage()),
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ],
  );
}
