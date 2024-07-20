import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sit_in_the_cafeteria/src/components/my_container.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_notifier.dart';

class PenaltyPage extends ConsumerWidget {
  const PenaltyPage({super.key});
  static final _dateFormatter = DateFormat('yyyy/MM/dd');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservation = ref.watch(reservationProvider);

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
                  Icons.warning_amber_rounded,
                  size: 30,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 10),
                Text(
                  '利用停止中',
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
              '前回の予約のご利用を確認できなかったため、このアカウントは利用停止中です。',
            ),

            const SizedBox(height: 20),

            // 期間
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('利用停止期間：'),
                Text(
                  '2週間',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Text(
              '${_dateFormatter.format(reservation!.startTime!)}まで',
              style: TextStyle(color: Theme.of(context).colorScheme.primary),
            ),

            const SizedBox(height: 20),

            // イラスト
            SizedBox(
              width: 180,
              height: 120,
              child: Image.asset(
                'lib/src/assets/images/penalty.png',
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
