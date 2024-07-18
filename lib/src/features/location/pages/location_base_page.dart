import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final reservationState = ref.watch(reservationStateNotifierProvider);
    final reservationNotifier = ref.read(reservationNotifierProvider.notifier);

    // 予約情報を更新
    useEffect(() {
      Future(() => reservationNotifier.refresh());
      return null;
    }, []);

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
            // 予約がない場合 -> 予約なし画面を表示
            case ReservationState.noReservation:
              return const NoReservationPage();

            // 予約があり、まだ位置情報を送信していない場合 -> 位置情報送信画面を表示
            case ReservationState.hasReservation:
              return const LocationSendPage();

            // ペナルティがある場合 -> ペナルティ画面を表示
            case ReservationState.hasPenalty:
              return const PenaltyPage();

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
