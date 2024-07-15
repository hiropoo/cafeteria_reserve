import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/domain/reservation_state.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_notifier.dart';

part 'reservation_state_notifier.g.dart';

@riverpod
class ReservationStateNotifier extends _$ReservationStateNotifier {
  @override
  Future<ReservationState> build() async {
    final reservation = await ref.watch(reservationNotifierProvider.future);

    if (reservation == null) {
      return ReservationState.noReservation;
    } else {
      return ReservationState.hasReservation;
    }
  }
}
