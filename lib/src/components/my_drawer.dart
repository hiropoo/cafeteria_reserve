import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_drawer_tile.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/auth_state_notifier.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';
import 'package:sit_in_the_cafeteria/src/router/bottom_nav_index_notifier.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndexNotifier = ref.watch(bottomNavIndexProvider.notifier);

    return Drawer(
      child: Column(
        children: [
          // アプリロゴ、タイトル
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(top: 100, bottom: 30),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(
              Strings.appName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),

          // 予約
          MyDrawerTile(
            title: Strings.reservation,
            icon: Icons.event_note,
            onTap: () {
              context.pop();
              pageIndexNotifier.changeIndex(0);
              context.replaceNamed(AppRoute.reservation.name);
            },
          ),

          // 位置情報を送信
          MyDrawerTile(
            title: Strings.locationSend,
            icon: Icons.location_on,
            onTap: () {
              context.pop();
              pageIndexNotifier.changeIndex(1);
              context.replaceNamed(AppRoute.location.name);
            },
          ),

          // マイページ
          MyDrawerTile(
            title: Strings.myPage,
            icon: Icons.person,
            onTap: () {
              context.pop();
              pageIndexNotifier.changeIndex(2);
              context.replaceNamed(AppRoute.profile.name);
            },
          ),

          const Spacer(),

          // 設定
          MyDrawerTile(
            title: Strings.settings,
            icon: Icons.settings,
            onTap: () {
              context.pop();
              context.replaceNamed(AppRoute.settings.name);
            },
          ),

          // ログアウト
          MyDrawerTile(
            title: Strings.logout,
            icon: Icons.logout,
            onTap: () {
              final repositoryNotifier = ref.read(authStateNotifierProvider.notifier);
              repositoryNotifier.logout();
              context.pop();
              context.pushReplacementNamed(AppRoute.login.name);
            },
          ),

          const SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
