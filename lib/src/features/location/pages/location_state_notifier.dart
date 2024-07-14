import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/user_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/location/application/location_service.dart';
import 'package:sit_in_the_cafeteria/src/features/location/domains/location_state.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_notifier.dart';

part 'location_state_notifier.g.dart';

@riverpod
class LocationStateNotifier extends _$LocationStateNotifier {
  @override
  Future<LocationState> build() async {
    final reservation = await ref.watch(reservationNotifierProvider.future);

    if (reservation == null) {
      return LocationState.noReservation;
    } else {
      return LocationState.locationNotSent;
    }
  }

  // '位置情報を送信'ボタンが押された時の処理
  // updateArrived()は時間や位置情報が正しければ、サーバに到着情報を送信し、成功した場合はLocationStateをLocationState.locationSentに更新する
  // // 失敗した場合はLocationState.errorを返す
  Future<void> updateArrived() async {
    state = const AsyncLoading();

    final locationService = ref.read(locationServiceProvider);

    final user = ref.read(userNotifierProvider);
    final reservation = await ref.read(reservationNotifierProvider.future);

    final result = await locationService.updateArrived(userID: user.userID, cafeNum: reservation!.cafeNum);

    if (result) {
      state = const AsyncData(LocationState.locationSent);
    } else {
      state = const AsyncData(LocationState.error);
    }
  }
}
