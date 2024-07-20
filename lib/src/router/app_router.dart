import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/auth_base_page.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/login_page.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/sign_up_page.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/location_base_page.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/result_page/send_result_page.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/seat_confirm_page/cafeteria1_seat_page.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/seat_confirm_page/cafeteria2_seat_page.dart';
import 'package:sit_in_the_cafeteria/src/features/profile/pages/friend_list_page.dart';
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
  seat1,
  seat2,
  sendResult,
  profile,
  friendList,
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
        ],
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
                path: '/reservation',
                name: AppRoute.reservation.name,
                builder: (context, state) => const Center(child: ReservationPage()),
              ),
              GoRoute(
                  path: '/location',
                  name: AppRoute.location.name,
                  builder: (context, state) => const Center(
                        child: LocationBasePage(),
                      ),
                  routes: [
                    GoRoute(
                      path: 'sendResult',
                      name: AppRoute.sendResult.name,
                      builder: (context, state) => const SendResultPage(),
                    ),
                    GoRoute(
                      path: 'seat1',
                      name: AppRoute.seat1.name,
                      builder: (context, state) => Center(
                          child: Cafeteria1SeatPage(
                        seatNumber: state.extra as int,
                      )),
                    ),
                    GoRoute(
                      path: 'seat2',
                      name: AppRoute.seat2.name,
                      builder: (context, state) => Center(
                          child: Cafeteria2SeatPage(
                        seatNumber: state.extra as int,
                      )),
                    ),
                  ]),
              GoRoute(
                  path: '/profile',
                  name: AppRoute.profile.name,
                  builder: (context, state) => const Center(
                        child: MyPage(),
                      ),
                  routes: [
                    GoRoute(
                      path: 'friendList',
                      name: AppRoute.friendList.name,
                      builder: (context, state) => const FriendListPage(),
                    ),
                  ]),
            ],
          )
        ],
      )
    ],
  );
}
