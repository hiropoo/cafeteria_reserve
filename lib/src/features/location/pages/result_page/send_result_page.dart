import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_drawer.dart';
import 'package:sit_in_the_cafeteria/src/router/bottom_nav_index_notifier.dart';
import 'package:sit_in_the_cafeteria/src/router/page_controller_provider.dart';

class SendResultPage extends HookConsumerWidget {
  const SendResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageController = ref.watch(pageControllerProvider);
    final bottomNavIndex = ref.watch(bottomNavIndexProvider);
    final notifier = ref.read(bottomNavIndexProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "位置情報を送信",
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
      ),
      drawer: const MyDrawer(),

      // 位置情報送信後の画面
      body: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('data'),
            ],
          ),
        ),
      ),
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
