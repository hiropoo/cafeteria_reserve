import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/location/data/location_repository.dart';
import 'package:sit_in_the_cafeteria/src/features/location/domains/location_state.dart';

part 'location_service.g.dart';

@riverpod
LocationService locationService(LocationServiceRef ref) => LocationService(locationRepository: ref.read(locationRepositoryProvider));

class LocationService {
  final LocationRepository _locationRepository;

  const LocationService({required LocationRepository locationRepository}) : _locationRepository = locationRepository;

  // 位置情報を送信することができる時間帯かどうかを確認する処理 (未実装)
  Future<bool> _isTimeValid() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  // 現在学食付近にいるかどうかを確認する処理 (未実装)
  Future<bool> _isNearCafeteria() async {
    await Future.delayed(const Duration(seconds: 1));

    return false;
  }

  /// 時間内に学食に到着していたことをレポジトリを通してサーバに送信する処理
  /// 無事サーバに到着情報を送信した場合は、reservationNotifierを更新
  Future<LocationState> updateArrived({required String userID, required int cafeNum}) async {
    Future.delayed(const Duration(seconds: 1));

    if (!await _isTimeValid()) {
      return LocationState.timeError;
    }

    if (!await _isNearCafeteria()) {
      return LocationState.locationError;
    }

    if (await _locationRepository.sendArrived(userID: userID, cafeNum: cafeNum)) {
      return LocationState.locationSent;
    } else {
      return LocationState.connectionError;
    }
  }
}
