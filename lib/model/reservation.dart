import 'package:freezed_annotation/freezed_annotation.dart';
part 'reservation.freezed.dart';

@freezed
class Reservation with _$Reservation {
  const factory Reservation({
    required DateTime startTime,
    required DateTime endTime,
    required int cafeNum,
    required List<int> seatNum,
    required List<String> members,
    required bool isArrived,
  }) = _Reservation;
}