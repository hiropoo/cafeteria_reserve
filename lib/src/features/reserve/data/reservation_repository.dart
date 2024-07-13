import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/domain/reservation.dart';
import 'package:sit_in_the_cafeteria/src/utils/repository.dart';

part 'reservation_repository.g.dart';

@riverpod
ReservationRepository reservationRepository(ReservationRepositoryRef ref) => ReservationRepository();

class ReservationRepository extends Repository {
  ReservationRepository();

  /// 予約情報をサーバから取得する処理
  /// request -> "fetchReservation userID"
  /// response -> "success userID:userName,userID:userName,... cafeNum seatNum startTime endTime went"
  Future<Reservation?> fetchReservation({required String userID}) async {
    debugPrint('getReservation method called');

    // サーバから予約情報を取得
    await connect();
    final response = await request("getReservation $userID");

    final List<String> responseList = response.split(" ");

    if (responseList.first == "failure") {
      final message = responseList[1];
      return null;
    } else if (responseList.first == "success") {
      return Reservation.fromResponse(responseList);
    } else {
      return Future.error('unknown response from server');
    }
  }
}
