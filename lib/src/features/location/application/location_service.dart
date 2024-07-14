import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/location/data/location_repository.dart';

part 'location_service.g.dart';

@riverpod
LocationService locationService(LocationServiceRef ref) => LocationService(locationRepository: ref.read(locationRepositoryProvider));

class LocationService {
  final LocationRepository _locationRepository;

  const LocationService({required LocationRepository locationRepository}) : _locationRepository = locationRepository;

  // 位置情報を送信することができる時間帯かどうかを確認する処理 (未実装)
  bool _isTimeValid() {
    return true;
  }

  // 現在学食付近にいるかどうかを確認する処理 (未実装)
  bool _isNearCafeteria() {
    return true;
  }

  /// 時間内に学食に到着していたことをレポジトリを通してサーバに送信する処理
  /// 無事サーバに到着情報を送信した場合は、reservationNotifierを更新し、trueを返す
  /// サーバに到着情報を送信できなかった場合は、falseを返す
  Future<bool> updateArrived({required String userID, required int cafeNum}) async {
    Future.delayed(const Duration(seconds: 1));

    if (_isTimeValid() && _isNearCafeteria()) {
      final result = await _locationRepository.sendArrived(userID: userID, cafeNum: cafeNum);
      return result;
    } else {
      return false;
    }
  }
}
