import 'package:flutter/material.dart';
import 'package:sit_in_the_cafeteria/src/components/location_page_tile.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/components/my_drawer.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/seat_page.dart';

class LocationSendPage extends StatelessWidget {
  const LocationSendPage({super.key});

  @override
  Widget build(BuildContext context) {
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

      // 位置情報を送信する画面
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // 予約した学食
                    const LocationPageTile(header: '予約した学食', content: '第１食堂'),

                    const SizedBox(height: 10),

                    // 予約時間
                    const LocationPageTile(header: '予約時間', content: '12:00 ~ 12:20'),

                    const SizedBox(height: 10),

                    // 予約した座席
                    const LocationPageTile(header: '予約した座席', content: '12'),

                    // 座席を確認
                    GestureDetector(
                      onTap: () {
                        // 座席確認画面に遷移
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SeatPage()));
                      },
                      child: Row(
                        children: [
                          Icon(
                            Icons.arrow_right_rounded,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            "座席の確認はこちら",
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // 説明
              Text(
                Strings.locationDescription,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // 位置情報を送信するボタン
              MyButton(
                onPressed: () {},
                child: const Text(
                  "位置情報を送信",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
