// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$User {
  String get userName => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  int get studentID => throw _privateConstructorUsedError;
  String get userID => throw _privateConstructorUsedError;
  List<Friend> get friendList => throw _privateConstructorUsedError;
  bool get hasReservation => throw _privateConstructorUsedError;
  Reservation get reservation => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String userName,
      String password,
      int studentID,
      String userID,
      List<Friend> friendList,
      bool hasReservation,
      Reservation reservation});

  $ReservationCopyWith<$Res> get reservation;
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? password = null,
    Object? studentID = null,
    Object? userID = null,
    Object? friendList = null,
    Object? hasReservation = null,
    Object? reservation = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      studentID: null == studentID
          ? _value.studentID
          : studentID // ignore: cast_nullable_to_non_nullable
              as int,
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      friendList: null == friendList
          ? _value.friendList
          : friendList // ignore: cast_nullable_to_non_nullable
              as List<Friend>,
      hasReservation: null == hasReservation
          ? _value.hasReservation
          : hasReservation // ignore: cast_nullable_to_non_nullable
              as bool,
      reservation: null == reservation
          ? _value.reservation
          : reservation // ignore: cast_nullable_to_non_nullable
              as Reservation,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReservationCopyWith<$Res> get reservation {
    return $ReservationCopyWith<$Res>(_value.reservation, (value) {
      return _then(_value.copyWith(reservation: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userName,
      String password,
      int studentID,
      String userID,
      List<Friend> friendList,
      bool hasReservation,
      Reservation reservation});

  @override
  $ReservationCopyWith<$Res> get reservation;
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? password = null,
    Object? studentID = null,
    Object? userID = null,
    Object? friendList = null,
    Object? hasReservation = null,
    Object? reservation = null,
  }) {
    return _then(_$UserImpl(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      studentID: null == studentID
          ? _value.studentID
          : studentID // ignore: cast_nullable_to_non_nullable
              as int,
      userID: null == userID
          ? _value.userID
          : userID // ignore: cast_nullable_to_non_nullable
              as String,
      friendList: null == friendList
          ? _value._friendList
          : friendList // ignore: cast_nullable_to_non_nullable
              as List<Friend>,
      hasReservation: null == hasReservation
          ? _value.hasReservation
          : hasReservation // ignore: cast_nullable_to_non_nullable
              as bool,
      reservation: null == reservation
          ? _value.reservation
          : reservation // ignore: cast_nullable_to_non_nullable
              as Reservation,
    ));
  }
}

/// @nodoc

class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.userName,
      required this.password,
      required this.studentID,
      required this.userID,
      required final List<Friend> friendList,
      required this.hasReservation,
      required this.reservation})
      : _friendList = friendList;

  @override
  final String userName;
  @override
  final String password;
  @override
  final int studentID;
  @override
  final String userID;
  final List<Friend> _friendList;
  @override
  List<Friend> get friendList {
    if (_friendList is EqualUnmodifiableListView) return _friendList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_friendList);
  }

  @override
  final bool hasReservation;
  @override
  final Reservation reservation;

  @override
  String toString() {
    return 'User(userName: $userName, password: $password, studentID: $studentID, userID: $userID, friendList: $friendList, hasReservation: $hasReservation, reservation: $reservation)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.studentID, studentID) ||
                other.studentID == studentID) &&
            (identical(other.userID, userID) || other.userID == userID) &&
            const DeepCollectionEquality()
                .equals(other._friendList, _friendList) &&
            (identical(other.hasReservation, hasReservation) ||
                other.hasReservation == hasReservation) &&
            (identical(other.reservation, reservation) ||
                other.reservation == reservation));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      userName,
      password,
      studentID,
      userID,
      const DeepCollectionEquality().hash(_friendList),
      hasReservation,
      reservation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);
}

abstract class _User implements User {
  const factory _User(
      {required final String userName,
      required final String password,
      required final int studentID,
      required final String userID,
      required final List<Friend> friendList,
      required final bool hasReservation,
      required final Reservation reservation}) = _$UserImpl;

  @override
  String get userName;
  @override
  String get password;
  @override
  int get studentID;
  @override
  String get userID;
  @override
  List<Friend> get friendList;
  @override
  bool get hasReservation;
  @override
  Reservation get reservation;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
