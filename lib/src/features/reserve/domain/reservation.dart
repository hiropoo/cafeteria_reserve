import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

part 'reservation.freezed.dart';

@freezed
class Reservation with _$Reservation {
  static final DateFormat _formatter = DateFormat('yyyy-MM-dd-HH:mm:ss');

  const factory Reservation({
    required DateTime? startTime,
    required DateTime? endTime,
    required int cafeNum,
    required List<int> seatNumbers,
    required List<List<String>> members,
    required bool isArrived,
  }) = _Reservation;

  // responseからReservationオブジェクトを生成するシングルトンコンストラクタ
  // responseList: success userID:userName,userID:userName,... cafeNum seatNum,seatNum,... startTime endTime went
  factory Reservation.fromResponse(List<String> responseList) {
    final List<String> members = responseList[1].split(',');
    final List<List<String>> membersList = members.map((e) => e.split(':')).toList();

    final int cafeNum = int.parse(responseList[2]);
    final List<int> seatNum = responseList[3].split(',').map((seatNum) => int.parse(seatNum)).toList();

    final DateTime startTime = _formatter.parse(responseList[4]);
    final DateTime endTime = _formatter.parse(responseList[5]);
    final bool isArrived = responseList[6] == 'true\n';

    return Reservation(
      startTime: startTime,
      endTime: endTime,
      cafeNum: cafeNum,
      seatNumbers: seatNum,
      members: membersList,
      isArrived: isArrived,
    );
  }
}
