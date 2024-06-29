import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'bottom_nav_index_notifier.g.dart';

@riverpod
class BottomNavIndex extends _$BottomNavIndex {
  @override
  int build() {
    return 0;
  }

  // add your methods to change data here
  void changeIndex(int index) {
    state = index;
  }
}
