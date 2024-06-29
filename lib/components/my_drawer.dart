import 'package:flutter/material.dart';
import 'package:sit_in_the_cafeteria/components/my_drawer_tile.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
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

          // 位置情報を送信
          MyDrawerTile(
            title: '位置情報',
            icon: Icons.location_on,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          // マイページ
          MyDrawerTile(
            title: 'マイページ',
            icon: Icons.location_on,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          // 設定
          MyDrawerTile(
            title: '設定',
            icon: Icons.settings,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const Spacer(),

          // ログアウト
          MyDrawerTile(
            title: 'ログアウト',
            icon: Icons.logout,
            onTap: () {
              Navigator.pop(context);
            },
          ),

          const SizedBox(
            height: 45,
          )
        ],
      ),
    );
  }
}
