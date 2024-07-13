import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'location_service.g.dart';

@riverpod
LocationService locationService(LocationServiceRef ref) => const LocationService();

class LocationService {
  const LocationService();

  // 現在学食付近にいるかどうかを確認する処理
  Future<bool> checkArrived() async {
    return Future.value(false);
  }

  

}