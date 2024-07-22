import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'use_mobile_theme.g.dart';

@riverpod
class UseMobileTheme extends _$UseMobileTheme {
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    final bool useMobileTheme = prefs.getBool('useMobileTheme') ?? false;

    return useMobileTheme;
  }

  // モバイルのテーマを利用するかどうかの切り替え
  void toggleUseMobileTheme() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('useMobileTheme', state == const AsyncData(true) ? false : true);

    state = AsyncData(state == const AsyncData(true) ? false : true);
  }
}
