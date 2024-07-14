import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/domains/user.dart';

part 'user_notifier.g.dart';

@Riverpod(keepAlive: true)
class UserNotifier extends _$UserNotifier {
  @override
  User build() {
    return const User(
      userName: '',
      password: '',
      studentID: -1,
      userID: '',
      friendList: [],
      hasReservation: false,
    );
  }

  // ユーザー名、パスワード、学籍番号、ユーザIDを更新
  void updateAll({required String userName, required String password, required int studentID, required String userID}) {
    state = state.copyWith(userName: userName, password: password, studentID: studentID, userID: userID);
  }

  // ユーザ名とパスワードを更新
  void updateUserNameAndPassword({required String userName, required String password}) {
    state = state.copyWith(userName: userName, password: password);
  }

  // ユーザIDと学籍番号を更新
  void updateUserIDAndStudentID({required String userID, required int studentID}) {
    state = state.copyWith(userID: userID);
  }
}
