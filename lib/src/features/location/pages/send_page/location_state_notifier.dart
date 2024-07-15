import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/user_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/location/application/location_service.dart';
import 'package:sit_in_the_cafeteria/src/features/location/domains/location_state.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_notifier.dart';

part 'location_state_notifier.g.dart';

@riverpod
class LocationStateNotifier extends _$LocationStateNotifier {
  @override
  FutureOr<LocationState> build() async {
    return LocationState.locationNotSent;
  }

  // '位置情報を送信'ボタンが押された時の処理
  // updateArrived()は時間や位置情報が正しければ、サーバに到着情報を送信し、成功した場合はLocationStateを更新する
  Future<void> updateArrived() async {
    state = const AsyncLoading();

    final locationService = ref.read(locationServiceProvider);

    final user = ref.read(userNotifierProvider);
    final reservation = ref.read(reservationProvider);

    final locationState = await locationService.updateArrived(
      userID: user.userID,
      reservation: reservation!,
    );

    switch (locationState) {
      case LocationState.locationSent:
        state = const AsyncData(LocationState.locationSent);
        break;
      case LocationState.timeError:
        state = const AsyncData(LocationState.timeError);
        break;
      case LocationState.locationError:
        state = const AsyncData(LocationState.locationError);
        break;
      case LocationState.connectionError:
        state = const AsyncData(LocationState.connectionError);
        break;
      case LocationState.locationNotSent:
        state = const AsyncData(LocationState.locationNotSent);
        break;
      case LocationState.permissionError:
        state = const AsyncData(LocationState.permissionError);
        break;
    }
  }
}
