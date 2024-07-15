import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/domains/user.dart';
import 'package:sit_in_the_cafeteria/src/utils/repository.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) => AuthRepository();

class AuthRepository extends Repository {
  AuthRepository();

  /* ログイン処理
   * request -> "login userName password"
   * response -> "success userID studentID" or "failure message"
   */
  Future<User?> login({required String userName, required String password}) async {
    debugPrint('login method called');

    // サーバに通信してログイン処理を行う
    await connect();
    final response = await request("login $userName $password");

    final List<String> responseList = response.split(" ");

    // ログイン失敗時
    if (responseList.first == "failure") {
      final message = responseList[1];
      debugPrint('login failed : $message');
      return null;
    }
    // ログイン成功時
    else if (responseList.first == "success") {
      final userID = responseList[1];
      final studentID = int.parse(responseList[2]);

      debugPrint('login success');

      return User(
        userName: '',
        password: '',
        studentID: studentID,
        userID: userID,
        friendList: [],
        hasReservation: false,
      );
    } else {
      debugPrint('unknown response from server');
      return Future.error('unknown response from server');
    }
  }
}
