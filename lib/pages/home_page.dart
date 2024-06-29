import 'package:flutter/material.dart';
import 'package:sit_in_the_cafeteria/components/my_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "学食スワローズ",
          style: Theme.of(context).textTheme.titleLarge,
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

      // 位置情報を送信する画面
      body: const Center(
        child: Text("Home Page"),
      ),
    );
  }
}
