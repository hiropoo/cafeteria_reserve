import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';
import 'package:sit_in_the_cafeteria/src/router/bottom_nav_index_notifier.dart';

class SendResultPage extends HookConsumerWidget {
  const SendResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // 位置情報送信後の画面
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                Strings.locationSendResult,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor,
                ),
              ),

              // ホームへ戻るボタン
              MyButton(
                onPressed: () {
                  // ホームへ戻る
                  context.goNamed(AppRoute.location.name);
                  ref.read(bottomNavIndexProvider.notifier).changeIndex(1);
                },
                child: const Text('戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
