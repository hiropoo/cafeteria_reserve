import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/domains/user.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository repository(AuthRepositoryRef ref) => const AuthRepository();

class AuthRepository {
  static const String _serverIP = "localhost";
  static const int _serverPort = 12345;
  static Socket? _socket;

  const AuthRepository();

  /* サーバとの接続メソッド */
  Future connect() async {
    try {
      debugPrint('connecting to server');
      _socket = await Socket.connect(_serverIP, _serverPort);
      debugPrint('connected to server');
    } catch (e) {
      debugPrint('failed to connect to server');
      disconnect();
    }
  }

  /* サーバとの接続を切断するメソッド */
  void disconnect() {
    if (_socket != null) {
      _socket!.close();
      _socket = null;
    }
  }

  /* サーバにrequestを送信するメソッド */
  Future<String> request(String request) async {
    if (_socket == null) {
      return Future.error('not connected to server');
    }

    try {
      // サーバにrequestを送信
      debugPrint('sending request: $request');
      _socket!.add(utf8.encode("$request\n"));

      // サーバからのresponseを受信
      final completer = Completer<String>();
      String response = '';
      _socket!.listen((data) {
        response += utf8.decode(data);
        if (response.endsWith('\n')) {
          completer.complete(response);
          debugPrint('received response: $response');
        }
      });

      return completer.future;
    } catch (e) {
      return Future.error('failed to send request to server');
    } finally {
      disconnect();
    }
  }

  /* ログイン処理
   * ログイン成功時にはtrueを返す
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
