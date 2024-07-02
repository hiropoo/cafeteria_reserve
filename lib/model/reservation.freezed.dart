// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$Reservation {
  DateTime get startTime => throw _privateConstructorUsedError;
  DateTime get endTime => throw _privateConstructorUsedError;
  int get cafeNum => throw _privateConstructorUsedError;
  List<int> get seatNum => throw _privateConstructorUsedError;
  List<String> get members => throw _privateConstructorUsedError;
  bool get isArrived => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ReservationCopyWith<Reservation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReservationCopyWith<$Res> {
  factory $ReservationCopyWith(
          Reservation value, $Res Function(Reservation) then) =
      _$ReservationCopyWithImpl<$Res, Reservation>;
  @useResult
  $Res call(
      {DateTime startTime,
      DateTime endTime,
      int cafeNum,
      List<int> seatNum,
      List<String> members,
      bool isArrived});
}

/// @nodoc
class _$ReservationCopyWithImpl<$Res, $Val extends Reservation>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? cafeNum = null,
    Object? seatNum = null,
    Object? members = null,
    Object? isArrived = null,
  }) {
    return _then(_value.copyWith(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cafeNum: null == cafeNum
          ? _value.cafeNum
          : cafeNum // ignore: cast_nullable_to_non_nullable
              as int,
      seatNum: null == seatNum
          ? _value.seatNum
          : seatNum // ignore: cast_nullable_to_non_nullable
              as List<int>,
      members: null == members
          ? _value.members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isArrived: null == isArrived
          ? _value.isArrived
          : isArrived // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReservationImplCopyWith<$Res>
    implements $ReservationCopyWith<$Res> {
  factory _$$ReservationImplCopyWith(
          _$ReservationImpl value, $Res Function(_$ReservationImpl) then) =
      __$$ReservationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime startTime,
      DateTime endTime,
      int cafeNum,
      List<int> seatNum,
      List<String> members,
      bool isArrived});
}

/// @nodoc
class __$$ReservationImplCopyWithImpl<$Res>
    extends _$ReservationCopyWithImpl<$Res, _$ReservationImpl>
    implements _$$ReservationImplCopyWith<$Res> {
  __$$ReservationImplCopyWithImpl(
      _$ReservationImpl _value, $Res Function(_$ReservationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? startTime = null,
    Object? endTime = null,
    Object? cafeNum = null,
    Object? seatNum = null,
    Object? members = null,
    Object? isArrived = null,
  }) {
    return _then(_$ReservationImpl(
      startTime: null == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      endTime: null == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as DateTime,
      cafeNum: null == cafeNum
          ? _value.cafeNum
          : cafeNum // ignore: cast_nullable_to_non_nullable
              as int,
      seatNum: null == seatNum
          ? _value._seatNum
          : seatNum // ignore: cast_nullable_to_non_nullable
              as List<int>,
      members: null == members
          ? _value._members
          : members // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isArrived: null == isArrived
          ? _value.isArrived
          : isArrived // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ReservationImpl implements _Reservation {
  const _$ReservationImpl(
      {required this.startTime,
      required this.endTime,
      required this.cafeNum,
      required final List<int> seatNum,
      required final List<String> members,
      required this.isArrived})
      : _seatNum = seatNum,
        _members = members;

  @override
  final DateTime startTime;
  @override
  final DateTime endTime;
  @override
  final int cafeNum;
  final List<int> _seatNum;
  @override
  List<int> get seatNum {
    if (_seatNum is EqualUnmodifiableListView) return _seatNum;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_seatNum);
  }

  final List<String> _members;
  @override
  List<String> get members {
    if (_members is EqualUnmodifiableListView) return _members;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_members);
  }

  @override
  final bool isArrived;

  @override
  String toString() {
    return 'Reservation(startTime: $startTime, endTime: $endTime, cafeNum: $cafeNum, seatNum: $seatNum, members: $members, isArrived: $isArrived)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReservationImpl &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.cafeNum, cafeNum) || other.cafeNum == cafeNum) &&
            const DeepCollectionEquality().equals(other._seatNum, _seatNum) &&
            const DeepCollectionEquality().equals(other._members, _members) &&
            (identical(other.isArrived, isArrived) ||
                other.isArrived == isArrived));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      startTime,
      endTime,
      cafeNum,
      const DeepCollectionEquality().hash(_seatNum),
      const DeepCollectionEquality().hash(_members),
      isArrived);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      __$$ReservationImplCopyWithImpl<_$ReservationImpl>(this, _$identity);
}

abstract class _Reservation implements Reservation {
  const factory _Reservation(
      {required final DateTime startTime,
      required final DateTime endTime,
      required final int cafeNum,
      required final List<int> seatNum,
      required final List<String> members,
      required final bool isArrived}) = _$ReservationImpl;

  @override
  DateTime get startTime;
  @override
  DateTime get endTime;
  @override
  int get cafeNum;
  @override
  List<int> get seatNum;
  @override
  List<String> get members;
  @override
  bool get isArrived;
  @override
  @JsonKey(ignore: true)
  _$$ReservationImplCopyWith<_$ReservationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
