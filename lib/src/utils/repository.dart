import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

class Repository {
  static const String _serverIP = "192.168.2.105";
  static const int _serverPort = 12345;
  static Socket? _socket;

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
}
