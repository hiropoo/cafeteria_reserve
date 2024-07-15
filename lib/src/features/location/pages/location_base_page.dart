import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/send_page/location_send_page.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/domain/reservation_state.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_state_notifier.dart';

class LocationBasePage extends ConsumerWidget {
  const LocationBasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservationState = ref.watch(reservationStateNotifierProvider);

    return Scaffold(
      // 位置情報送信画面
      body: reservationState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stackTrace) {
          debugPrint(e.toString());
          return const Center(child: Text('エラーが発生しました'));
        },
        data: (locationState) {
          switch (locationState) {
            // 予約がない場合
            case ReservationState.noReservation:
              return Center(
                child: Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  '予約がありません',
                ),
              );

            // 予約があり、まだ位置情報を送信していない場合 => 位置情報送信画面を表示
            case ReservationState.hasReservation:
              return const LocationSendPage();

            // エラーが発生した場合
            case ReservationState.error:
              return Center(
                child: Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  'エラーが発生しました',
                ),
              );
          }
        },
      ),
    );
  }
}
