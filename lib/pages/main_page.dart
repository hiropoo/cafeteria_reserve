import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/notifiers/bottom_nav_index_notifier.dart';
import 'package:sit_in_the_cafeteria/pages/home_page.dart';
import 'package:sit_in_the_cafeteria/pages/location_send_page.dart';
import 'package:sit_in_the_cafeteria/pages/my_page.dart';

class MainPage extends HookConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = usePageController();
    final bottomNavIndex = ref.watch(bottomNavIndexProvider);
    final notifier = ref.read(bottomNavIndexProvider.notifier);

    return Scaffold(
      body: PageView(
        controller: pageController,
        children: const [
          // ホーム画面
          HomePage(),

          // 位置情報送信画面
          LocationSendPage(),

          // マイページ画面
          MyPage(),
        ],
        onPageChanged: (index) => notifier.changeIndex(index),
      ),

      // bottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          // ホーム
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'ホーム',
          ),

          // 位置情報
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: '位置情報',
          ),

          // マイページ
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'マイページ',
          ),
        ],
        currentIndex: bottomNavIndex,
        onTap: (index) {
          notifier.changeIndex(index);
          pageController.animateToPage(index, duration: const Duration(milliseconds: 250), curve: Curves.easeInOut);
        },
      ),
    );
  }
}
