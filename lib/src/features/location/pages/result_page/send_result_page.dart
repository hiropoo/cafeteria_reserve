import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/components/my_container.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_notifier.dart';

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
                    Strings.locationSendResultTitle,
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
                Strings.locationSendResultDescription1,
              ),

              const SizedBox(height: 20),

              const Text(
                textAlign: TextAlign.center,
                Strings.locationSendResultDescription2,
              ),

              const SizedBox(height: 20),

              // イラスト
              SizedBox(
                width: 100,
                child: Image.asset(
                  'lib/src/assets/images/send-result.png',
                ),
              ),

              const SizedBox(height: 20),

              MyButton(
                onPressed: () {
                  HapticFeedback.lightImpact();
                  ref.read(reservationNotifierProvider.notifier).refresh();
                  context.pop();
                },
                child: const Text(Strings.returnButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
