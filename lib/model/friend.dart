import 'package:freezed_annotation/freezed_annotation.dart';
part 'friend.freezed.dart';

@freezed
class Friend with _$Friend {
  const factory Friend({
    required String friendID,
    required String friendName,
  }) = _Friend;
}