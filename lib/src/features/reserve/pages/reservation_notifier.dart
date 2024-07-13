import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/user_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/data/reservation_repository.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/domain/reservation.dart';

part 'reservation_notifier.g.dart';

@riverpod
class ReservationNotifier extends _$ReservationNotifier {
  @override
  Future<Reservation> build() async {
    // サーバから予約情報を取得
    final repository = ref.read(reservationRepositoryProvider);
    final user = ref.watch(userNotifierProvider);
    final reservation = await repository.fetchReservation(userID: user.userID);

    // 取得した情報をもとに、Reservationオブジェクトを生成
    return reservation ?? Future.value(Reservation(
            members: List.empty(),
            cafeNum: 0,
            seatNumbers: [0],
            startTime: DateTime.now(),
            endTime: DateTime.now(),
            isArrived: false,
          ));
  }

  // add your methods to change data here
}
