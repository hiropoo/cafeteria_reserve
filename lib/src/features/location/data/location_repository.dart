import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/utils/repository.dart';

part 'location_repository.g.dart';

@riverpod
LocationRepository locationRepository(LocationRepositoryRef ref) => LocationRepository();

class LocationRepository extends Repository {
  LocationRepository();

  /// 時間内に学食に到着していたことをサーバに送信する処理
  /// request -> "updateArrived userID cafeNum"
  /// response -> "success" or "failure message"
  Future<bool> sendArrived({required String userID, required int cafeNum}) async {
    debugPrint('updateArrived method called');

    await Future.delayed(const Duration(seconds: 1));

    // サーバに到着情報を送信
    await connect();
    final response = await request("updateArrived $userID $cafeNum");

    final List<String> responseList = response.split(" ");

    if (responseList.first == "failure") {
      final message = responseList.sublist(1).join(" ");
      debugPrint('updateArrived failed : $message');

      return false;
    } else if (responseList.first == "success") {
      return true;
    } else {
      return Future.error('unknown response from server');
    }
  }
}
