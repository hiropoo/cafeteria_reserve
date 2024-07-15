import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/user_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/data/reservation_repository.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/domain/reservation.dart';

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
