import 'package:flutter/material.dart';
import 'package:sit_in_the_cafeteria/components/my_button.dart';
import 'package:sit_in_the_cafeteria/components/my_drawer.dart';
import 'package:sit_in_the_cafeteria/components/seat.dart';
import 'package:sit_in_the_cafeteria/constant/my_color.dart';

class LocationSendPage extends StatelessWidget {
  const LocationSendPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColor.appBar,
        title: Center(
          child: Text(
            "位置情報を送信",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      drawer: const MyDrawer(),

      // 位置情報を送信する画面
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            MyButton(
              onPressed: () {},
              child: const Text(
                "位置情報を送信",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
