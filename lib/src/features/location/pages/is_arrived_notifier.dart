import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/user_notifier.dart';

part 'is_arrived_notifier.g.dart';

@riverpod
class IsArrivedNotifier extends _$IsArrivedNotifier {
  @override
  Future<bool> build() {
    // ReservationNotifierのisArrivedを参照
    
    return Future.value(false);
  }

  // 学食近辺にいるか確認し、学食近辺にいるのならstateを更新
}
