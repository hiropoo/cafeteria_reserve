import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class LoginModel extends ChangeNotifier {
  String _name = ''; // ユーザー名
  String _password = ''; // パスワード
  bool _isObscure = true; // パスワードの表示非表示
  bool _isConnecting = false; // サーバーに接続中かどうか

  static const String SERVER_IP = "192.168.2.105";
  static const int PORT = 12345;

  bool _isConnected = false; // サーバーに接続しているかどうか
  Socket? _socket; // サーバーとの通信用ソケット
  Function()? onError; // エラー時のコールバック

  String get email => _name;
  String get password => _password;
  bool get isObscure => _isObscure;
  bool get isConnecting => _isConnecting;

  void setEmail(String email) {
    _name = email;
  }

  void setPassword(String password) {
    _password = password;
  }

  // パスワードの表示非表示を切り替える
  void toggleObscure() {
    _isObscure = !_isObscure;
    notifyListeners();
  }

  // サーバに接続中（ログイン処理中）かどうかを切り替える
  void changeConnecting(bool isConnecting) {
    _isConnecting = isConnecting;
    notifyListeners();
  }

  // ログイン処理　サーバにデータを送信
  // サーバーに接続するメソッド
  Future connect() async {
    if (_isConnected) {
      debugPrint("Already connected to server");
      return;
    }

    try {
      _socket = await Socket.connect(SERVER_IP, PORT);
      _isConnected = true;

      debugPrint("Connected to server");
    } catch (e) {
      debugPrint("Failed to connect to server: $e");
      _errorDisconnect();
      onError!();
    }
  }

  // エラー時にサーバーとの接続を切断するメソッド
  void _errorDisconnect() {
    if (_socket != null) {
      _socket!.destroy();
      _isConnected = false;
    }
  }

  // サーバーとの接続を切断するメソッド
  void disconnect() {
    if (_socket != null) {
      _socket!.destroy();
      _isConnected = false;
    }
  }



  // サーバーにデータを送信するメソッド
  Future send(String message) async {
    if (!_isConnected || _socket == null) {
      debugPrint("Socket is null or not connected");
      return;
    }

    // データを送信
    try {
      _socket!.add(utf8.encode("$message\n"));
      _socket!.flush();
      debugPrint("Data sent to server: $message");
    } catch (e) {
      debugPrint("Failed to send data to server: $e");
    }
  }

  // サーバからデータを受信するメソッド
  Future<String> receive() async {
    if (!_isConnected || _socket == null) {
      debugPrint("Socket is null or not connected");
      return '';
    }

    // データを受信
    try {
      final completer = Completer<String>();
      _socket!.listen(
        (List<int> res) {
          final String data = utf8.decode(res);
          completer.complete(data);
        },
        onError: (e) {
          debugPrint("Error: $e");
          completer.completeError(e);
        },
        onDone: () {
          debugPrint("Connection closed");
        },
      );
      return completer.future;
    } catch (e) {
      debugPrint("Failed to receive data from server: $e");
      return '';
    }
  }
}
