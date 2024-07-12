import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/data/auth_repository.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/domains/auth_state.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/user_notifier.dart';

part 'auth_state_notifier.g.dart';

/* 
 * このAuthStateNotifierを監視して、ログイン状態に応じて最初の画面を切り替える
 */
@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  @override
  Future<AuthState> build() async {
    // prefsからログイン情報を取得
    final prefs = await SharedPreferences.getInstance();
    final userName = prefs.getString('userName'); // ユーザ名
    final userID = prefs.getString('userID'); // ユーザID
    final password = prefs.getString('password'); // パスワード
    final studentID = prefs.getInt('studentID'); // 学籍番号
    final loggedIn = prefs.getBool('loggedIn') ?? false; // ログイン状態

    // テスト用
    // const userName = null;

    // ログイン情報がローカルにない場合
    if (userName == null || userID == null || password == null || studentID == null) {
      return AuthState.signUp;
    }
    // ログイン情報がローカルにあるが、前回ログアウトしている場合
    else if (!loggedIn) {
      return AuthState.loggedOut;
    }
    // ログイン情報がローカルにあり、前回ログアウトしていない場合
    else {
      // ログイン情報を用いてログイン処理を行う
      final repository = ref.read(authRepositoryProvider);
      final user = await repository.login(userName: userName, password: password);

      // ログイン処理が失敗した場合は、ログアウト状態にする
      if (user == null) {
        return AuthState.loggedOut;
      }

      // ログイン処理が成功した場合は、ユーザ情報を更新
      ref.read(userNotifierProvider.notifier).updateAll(
            userName: userName,
            password: password,
            studentID: studentID,
            userID: userID,
          );

      // ログイン処理が成功した場合
      return AuthState.loggedIn;
    }
  }

  // ログイン処理
  Future<bool> login({required String userName, required String password}) async {
    state = const AsyncValue.loading(); // ローディング状態にする

    await Future.delayed(const Duration(seconds: 1));

    final repository = ref.read(authRepositoryProvider);

    // 成功した場合 -> userID, studentIDが保存されたUserオブジェクト
    // 失敗した場合 -> null
    final user = await repository.login(userName: userName, password: password);

    // ログイン処理が失敗した場合
    if (user == null) {
      // エラー状態にする
      state = const AsyncValue.data(AuthState.loggedOut);
      return false;
    }

    // ユーザ情報を更新
    // ログイン処理が成功した場合は、ユーザ情報を更新
    ref.read(userNotifierProvider.notifier).updateAll(
          userName: userName,
          password: password,
          studentID: user.studentID,
          userID: user.userID,
        );

    // ローカルの状態も更新
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userName', userName);
    await prefs.setString('userID', user.userID);
    await prefs.setString('password', password);
    await prefs.setInt('studentID', user.studentID);
    await prefs.setBool('loggedIn', true);

    state = const AsyncValue.data(AuthState.loggedIn); // ログイン状態にする

    return true;
  }
}
