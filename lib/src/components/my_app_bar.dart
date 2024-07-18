import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool hasRefresh; // リフレッシュボタンを表示するかどうか
  final Function()? onRefresh; // リフレッシュボタンを押した時の処理
  const MyAppBar({super.key, required this.title, this.hasRefresh = false, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      // ドロワーメニューを開くボタン
      leading: Builder(
        builder: (BuildContext context) {
          return IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        },
      ),

      actions: [
        // リフレッシュボタン
        if (hasRefresh)
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: IconButton(
              icon: const Icon(Icons.refresh_rounded),
              onPressed: onRefresh,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
