import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/user_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/data/reservation_repository.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/domain/reservation.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/domain/reservation_state.dart';

part 'reservation_notifier.g.dart';

@Riverpod(keepAlive: true)
class ReservationNotifier extends _$ReservationNotifier {
  @override
  Future<Reservation?> build() async {
    // サーバから予約情報を取得
    final repository = ref.read(reservationRepositoryProvider);
    final user = ref.watch(userNotifierProvider);

    final reservation = await repository.fetchReservation(userID: user.userID);

    return reservation;
  }

  // 予約情報を削除
  void clear() {
    state = const AsyncData(null);
  }
}

@riverpod
Reservation? reservation(ReservationRef ref) {
  return ref.watch(reservationNotifierProvider).whenOrNull(
        data: (reservation) => reservation,
      );
}
@riverpod
class ReservationStateNotifier extends _$ReservationStateNotifier {
  @override
  Future<ReservationState> build() async {
    final reservation = ref.watch(reservationProvider);

    // 予約情報がない場合
    if (reservation == null) {
      return ReservationState.noReservation;
    }
    // 座席が-1の場合はペナルティあり
    else if (reservation.seatNumbers.first == -1) {
      return ReservationState.hasPenalty;
    }
    // すでにarrivedを送信している場合
    else if (reservation.isArrived) {
      return ReservationState.noReservation;
    }
    // 予約がある場合
    else {
      return ReservationState.hasReservation;
    }
  }
}
