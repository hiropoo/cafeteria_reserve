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
    debugPrint('fetchReservation method called');
    try {
      await connect();
      final response = await request("fetchReservation $userID");

      final List<String> responseList = response.split(" ");

      if (responseList.first == "failure") {
        if (responseList[1] == "noData") {
          return const Reservation(
            startTime: null,
            endTime: null,
            cafeNum: 0,
            seatNumbers: [],
            members: [],
            isArrived: false,
          );
        }
        debugPrint('fetchReservation failed : ${responseList[1]}');
        return null;
      } else if (responseList.first == "success") {
        return Reservation.fromResponse(responseList);
      } else {
        return Future.error('unknown response from server');
      }
    } catch (e) {
      return const Reservation(
        startTime: null,
        endTime: null,
        cafeNum: 0,
        seatNumbers: [],
        members: [],
        isArrived: false,
        isError: true,
      );
    }
  }

  /// 予約を削除する処理
  /// request -> "removeReservation userID1,userID2..."
  /// response -> "success" or "failure message"
  Future<bool> removeReservation({required List<String> memberIDs}) async {
    debugPrint('removeReservation method called');

    await connect();

    final userIDs = memberIDs.join(',');
    final response = await request("removeReservation $userIDs");

    final List<String> responseList = response.split(" ");

    if (responseList.first == "failure") {
      debugPrint('removeReservation failed : ${responseList[1]}');
      return false;
    } else if (responseList.first == "success") {
      return true;
    } else {
      return Future.error('unknown response from server');
    }
  }
}
