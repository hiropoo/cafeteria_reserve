import 'dart:math';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/constant/my_location.dart';
import 'package:sit_in_the_cafeteria/src/features/location/data/location_repository.dart';
import 'package:sit_in_the_cafeteria/src/features/location/domains/location_state.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/domain/reservation.dart';

part 'location_service.g.dart';

@riverpod
LocationService locationService(LocationServiceRef ref) => LocationService(locationRepository: ref.read(locationRepositoryProvider));

class LocationService {
  final LocationRepository _locationRepository;

  const LocationService({required LocationRepository locationRepository}) : _locationRepository = locationRepository;

  /// 時間内に学食に到着していたことをレポジトリを通してサーバに送信する処理
  /// 無事サーバに到着情報を送信した場合は、reservationNotifierを更新
  Future<LocationState> updateArrived({required String userID, required Reservation reservation}) async {
    if (!await _isTimeValid(reservation.startTime, reservation.endTime)) {
      return LocationState.timeError;
    }
    // 位置情報の許可をリクエスト
    if (!await _requestLocationPermission()) {
      debugPrint("Location permission not granted");
      return LocationState.permissionError;
    }

    if (!await _isNearCafeteria(reservation.cafeNum)) {
      return LocationState.locationError;
    }

    if (await _locationRepository.sendArrived(userID: userID, cafeNum: reservation.cafeNum)) {
      return LocationState.locationSent;
    } else {
      return LocationState.connectionError;
    }
  }

  // 位置情報を送信することができる時間帯かどうかを確認する処理 (未実装)
  bool _isTimeValid(DateTime? startTime, DateTime? endTime) {
    // 現在時刻を取得
    final DateTime now = DateTime.now();

    // 予約開始時間の5分前から予約終了時間の5分後までの間にいるかどうかをチェック
    if (now.isBefore(startTime!.subtract(const Duration(minutes: 5))) || now.isAfter(endTime!.add(const Duration(minutes: 5)))) {
      return false;
    }

    return true;
  }

  // 位置情報の許可をリクエストする処理
  Future<bool> _requestLocationPermission() async {
    final Location location = Location();

    // 許可の状態をチェック
    PermissionStatus permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      // 位置情報の許可をリクエスト
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return false;
      }
    }

    // ロケーションサービスが有効かどうかをチェック
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      // ロケーションサービスを有効にするようにリクエスト
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return false;
      }
    }

    return true;
  }

  // 現在学食付近にいるかどうかを確認する処理
  Future<bool> _isNearCafeteria(int cafeNum) async {
    final Location location = Location();

    // 現在の位置情報を取得
    LocationData currentLocation;
    try {
      currentLocation = await location.getLocation();
    } on Exception catch (e) {
      debugPrint("Could not get location: $e");
      return false;
    }

    // 学食の座標を取得
    final double cafeLat = MyLocation.cafeLocations[cafeNum]!['lat']!;
    final double cafeLng = MyLocation.cafeLocations[cafeNum]!['lng']!;

    // 距離を計算 (単位はメートル)
    final double distance = _calculateDistance(
      currentLocation.latitude!,
      currentLocation.longitude!,
      cafeLat,
      cafeLng,
    );

    // 学食の近くかどうかを判断（100メートル以内）
    debugPrint("Distance to cafeteria: $distance meters");
    return distance <= MyLocation.radius;
  }

  // 距離を計算する関数
  double _calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double R = 6371000; // 地球の半径 (メートル)
    final double dLat = _degToRad(lat2 - lat1);
    final double dLon = _degToRad(lon2 - lon1);
    final double a = sin(dLat / 2) * sin(dLat / 2) + cos(_degToRad(lat1)) * cos(_degToRad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
  }

  // 度をラジアンに変換
  double _degToRad(double deg) {
    return deg * (pi / 180);
  }
}
