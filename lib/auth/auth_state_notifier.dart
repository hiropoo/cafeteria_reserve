import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sit_in_the_cafeteria/auth/auth_state.dart';
import 'package:sit_in_the_cafeteria/notifiers/user_notifier.dart';
import 'package:sit_in_the_cafeteria/repository/repository.dart';

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
    // final userName = prefs.getString('userName'); // ユーザ名
    // final userID = prefs.getString('userID'); // ユーザID
    // final password = prefs.getString('password'); // パスワード
    // final studentID = prefs.getInt('studentID'); // 学籍番号
    // final loggedIn = prefs.getBool('loggedIn') ?? false; // ログイン状態

    // 仮のログイン情報
    const userName = 'user1';
    const userID = 'b3KV4-_wRRm3uCWx7pE7uw';
    const password = 'pass1';
    const studentID = 1234567890;
    const bool loggedIn = true;

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
      final repository = ref.read(repositoryProvider);
      final user = await repository.login(userName: userName, password: password);

      // ログイン処理が失敗した場合は、ログアウト状態にする
      if (user == null) {
        return AuthState.loggedOut;
      }

      // ログイン処理が成功した場合は、ユーザ情報を更新
      ref.read(userNotifierProvider.notifier).updateUserIDAndStudentID(
            userID: user.userID,
            studentID: user.studentID,
          );

      // ログイン処理が成功した場合
      return AuthState.loggedIn;
    }
  }
}
