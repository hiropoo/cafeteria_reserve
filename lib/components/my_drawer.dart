import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/components/my_drawer_tile.dart';
import 'package:sit_in_the_cafeteria/notifiers/bottom_nav_index_notifier.dart';
import 'package:sit_in_the_cafeteria/providers/page_controller_provider.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageControllerProvider);
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
              '学食スワローズ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),

          // ホーム
          MyDrawerTile(
            title: 'ホーム',
            icon: Icons.home,
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 250), () {
                pageIndexNotifier.changeIndex(0);
                pageController.animateToPage(0, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
              });
            },
          ),

          // 位置情報を送信
          MyDrawerTile(
            title: '位置情報',
            icon: Icons.location_on,
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 250), () {
                pageIndexNotifier.changeIndex(1);
                pageController.animateToPage(1, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
              });
            },
          ),

          // マイページ
          MyDrawerTile(
            title: 'マイページ',
            icon: Icons.person,
            onTap: () {
              Navigator.pop(context);
              Future.delayed(const Duration(milliseconds: 250), () {
                pageIndexNotifier.changeIndex(2);
                pageController.animateToPage(2, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
              });
            },
          ),

          // 予約
          MyDrawerTile(
            title: '予約情報',
            icon: Icons.calendar_today,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Spacer(),

          // 設定
          MyDrawerTile(
            title: '設定',
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          // ログアウト
          MyDrawerTile(
            title: 'ログアウト',
            icon: Icons.logout,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
