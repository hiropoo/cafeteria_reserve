import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_app_bar.dart';
import 'package:sit_in_the_cafeteria/src/components/my_drawer.dart';
import 'package:sit_in_the_cafeteria/src/features/profile/pages/friend_list_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_notifier.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';
import 'package:sit_in_the_cafeteria/src/router/bottom_nav_index_notifier.dart';

class MainPage extends ConsumerWidget {
  final Widget child;

  const MainPage({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavIndex = ref.watch(bottomNavIndexProvider);
    final notifier = ref.read(bottomNavIndexProvider.notifier);
    final List<MyAppBar> headers = <MyAppBar>[
      const MyAppBar(title: '予約'),
      MyAppBar(
        title: '位置情報を送信',
        hasRefresh: true,
        onRefresh: () {
          ref.read(reservationNotifierProvider.notifier).refresh();
        },
      ),
      MyAppBar(
        title: 'マイページ',
        hasRefresh: true,
        onRefresh: () {
          ref.read(friendListNotifierProvider.notifier).refresh();
          ref.read(reservationNotifierProvider.notifier).refresh();
        },
      ),
    ];

    return Scaffold(
      appBar: headers[bottomNavIndex],
      drawer: const MyDrawer(),

      body: child,

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
          switch (index) {
            case 0:
              context.replace('/${AppRoute.reservation.name}');
              break;
            case 1:
              context.replace('/${AppRoute.location.name}');
              break;
            case 2:
              context.replace('/${AppRoute.profile.name}');
              break;
          }
        },
      ),
    );
  }
}
