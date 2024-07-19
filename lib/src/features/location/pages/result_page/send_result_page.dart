import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_container.dart';

class SendResultPage extends HookConsumerWidget {
  const SendResultPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: MyContainer(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // タイトル
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle_rounded,
                    size: 30,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '位置情報を送信しました',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // 説明
              const Text(
                textAlign: TextAlign.center,
                'ご予約の利用を確認しました。',
              ),

              const SizedBox(height: 20),

              const Text(
                textAlign: TextAlign.center,
                'ご利用ありがとうございました。',
              ),

              const SizedBox(height: 20),

              // イラスト
              SizedBox(
                width: 100,
                child: Image.asset(
                  'lib/src/assets/images/send-result.png',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
