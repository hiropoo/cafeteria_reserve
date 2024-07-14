import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_drawer.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/location_base_page.dart';
import 'package:sit_in_the_cafeteria/src/features/profile/pages/my_page.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_page.dart';
import 'package:sit_in_the_cafeteria/src/router/bottom_nav_index_notifier.dart';
import 'package:sit_in_the_cafeteria/src/router/page_controller_provider.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageControllerProvider);
    final bottomNavIndex = ref.watch(bottomNavIndexProvider);
    final notifier = ref.read(bottomNavIndexProvider.notifier);

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(), // ページスワイプを無効にする
        controller: pageController,
        children: const [
          // 予約画面
          ReservationPage(),

          // 位置情報送信画面
          LocationBasePage(),

          // マイページ画面
          MyPage(),
        ],
        onPageChanged: (index) => notifier.changeIndex(index),
      ),

      drawer: const MyDrawer(),

      // bottomNavigationBar
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          // 予約
          BottomNavigationBarItem(
            icon: Icon(Icons.event_note),
            label: '予約',
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
