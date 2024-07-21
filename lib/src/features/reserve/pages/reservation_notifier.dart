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
  void clear() async {
    final currentState = state;

    state = const AsyncLoading();

    // サーバから予約情報を削除
    final repository = ref.read(reservationRepositoryProvider);
    final memberIDs = currentState.asData!.value!.members.map((member) => member[0]).toList();

    final result = await repository.removeReservation(memberIDs: memberIDs);
    await Future.delayed(const Duration(milliseconds: 600));

    if (result) {
      // 予約情報を削除
      state = const AsyncData(null);
    } else {
      state = currentState;
    }
  }

  // 予約情報をサーバから取得して更新
  void refresh() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 300));

    // サーバから予約情報を取得
    final repository = ref.read(reservationRepositoryProvider);
    final user = ref.watch(userNotifierProvider);

    final reservation = await repository.fetchReservation(userID: user.userID);

    state = AsyncData(reservation);
  }
}

@riverpod
Reservation? reservation(ReservationRef ref) {
  return ref.watch(reservationNotifierProvider).when(
        data: (reservation) => reservation,
        loading: () => const Reservation(
          startTime: null,
          endTime: null,
          cafeNum: 0,
          seatNumbers: [],
          members: [],
          isArrived: false,
          isLoading: true,
        ),
        error: (error, _) => const Reservation(
          startTime: null,
          endTime: null,
          cafeNum: 0,
          seatNumbers: [],
          members: [],
          isArrived: false,
          isError: true,
        ),
      );
}

@riverpod
ReservationState reservationState(ReservationStateRef ref) {
  final reservation = ref.watch(reservationProvider);

  // 予約情報がない場合
  if (reservation == null) {
    return ReservationState.noReservation;
  }
  // ローディング中
  else if (reservation.isLoading) {
    return ReservationState.loading;
  }
  // エラーが発生している場合
  else if (reservation.isError) {
    return ReservationState.error;
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
