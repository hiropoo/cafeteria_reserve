import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/components/my_container.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';
import 'package:sit_in_the_cafeteria/src/router/bottom_nav_index_notifier.dart';

class NoReservationPage extends ConsumerWidget {
  const NoReservationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: MyContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // タイトル
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  Strings.noReservation,
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
              Strings.noReservationMessage1,
            ),

            const SizedBox(height: 20),

            const Text(
              textAlign: TextAlign.center,
              Strings.noReservationMessage2,
            ),

            const SizedBox(height: 20),

            // イラスト
            SizedBox(
              width: 180,
              height: 180,
              child: Image.asset(
                'lib/src/assets/images/no-reservation.png',
                fit: BoxFit.cover,
              ),
            ),

            // 予約ページへ
            MyButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                ref.read(bottomNavIndexProvider.notifier).changeIndex(0);
                context.pushNamed(AppRoute.reservation.name);
              },
              child: const Text(Strings.reservationPage),
            ),
          ],
        ),
      ),
    );
  }
}
