import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/domains/user.dart';

part 'user_notifier.g.dart';

@riverpod
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

  // ユーザ名とパスワードを更新
  void updateUserNameAndPassword({required String userName, required String password}) {
    state = state.copyWith(userName: userName, password: password);
  }

  // ユーザIDを更新
  void updateUserIDAndStudentID({required String userID, required int studentID}) {
    state = state.copyWith(userID: userID);
  }
}
