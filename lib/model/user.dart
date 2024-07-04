import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sit_in_the_cafeteria/model/friend.dart';
import 'package:sit_in_the_cafeteria/model/reservation.dart';

part 'user.freezed.dart';

@freezed
class User with _$User {
  const factory User({
    required String userName,
    required String password,
    required int studentID,
    required String userID,
    required List<Friend> friendList,
    required bool hasReservation,
  }) = _User;
}
