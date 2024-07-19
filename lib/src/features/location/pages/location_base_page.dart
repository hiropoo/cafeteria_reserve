import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/no_reservation_page/no_reservation_page.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/no_reservation_page/penalty_page.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/send_page/location_send_page.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/domain/reservation_state.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_notifier.dart';

class LocationBasePage extends HookConsumerWidget {
  const LocationBasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationState = ref.watch(reservationStateProvider);

    return Scaffold(
        // 位置情報送信画面
        body: switch (reservationState) {
      // 予約がない場合 -> 予約なし画面を表示
      ReservationState.noReservation => const NoReservationPage(),

      // 予約があり、まだ位置情報を送信していない場合 -> 位置情報送信画面を表示
      ReservationState.hasReservation => const LocationSendPage(),

      // ペナルティがある場合 -> ペナルティ画面を表示
      ReservationState.hasPenalty => const PenaltyPage(),

      // ローディング中の場合
      ReservationState.loading => const Center(
          child: CircularProgressIndicator(),
        ),

      // エラーが発生した場合
      ReservationState.error => Center(
          child: Text(
            style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            'エラーが発生しました',
          ),
        )
    });
  }
}
