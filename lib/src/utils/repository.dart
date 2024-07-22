import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sit_in_the_cafeteria/src/utils/env.dart';

class Repository {
  static String _serverIP = environment['serverIP'].toString();
  static int _serverPort = int.parse(environment['port'].toString());
  static Socket? _socket;

  // Getter と Setter を修正
  static String get serverIP => _serverIP;
  static set serverIP(String ip) {
    _serverIP = ip;
  }

  static int get serverPort => _serverPort;
  static set serverPort(int port) {
    _serverPort = port;
  }

  /* サーバとの接続メソッド */
  Future<void> connect() async {
    try {
      debugPrint('Connecting to server');
      _socket = await Socket.connect(_serverIP, _serverPort);
      debugPrint('Connected to server');
    } catch (e) {
      debugPrint('Failed to connect to server: $e');
      disconnect();
      rethrow; // エラーを再スロー
    }
  }

  /* サーバとの接続を切断するメソッド */
  void disconnect() {
    if (_socket != null) {
      _socket!.close();
      _socket = null;
      debugPrint('Disconnected from server');
    }
  }

  /* サーバにリクエストを送信するメソッド */
  Future<String> request(String request) async {
    if (_socket == null) {
      return Future.error('Not connected to server');
    }

    try {
      debugPrint('Sending request: $request');
      _socket!.add(utf8.encode("$request\n"));

      final completer = Completer<String>();
      StringBuffer responseBuffer = StringBuffer();

      _socket!.listen(
        (data) {
          responseBuffer.write(utf8.decode(data));
          if (responseBuffer.toString().endsWith('\n')) {
            completer.complete(responseBuffer.toString());
            debugPrint('Received response: ${responseBuffer.toString()}');
          }
        },
        onError: (error) {
          completer.completeError('Failed to receive response: $error');
        },
        onDone: () {
          disconnect(); // Ensure socket is closed on done
        },
        cancelOnError: true,
      );

      return completer.future;
    } catch (e) {
      throw Future.error('Failed to send request to server: $e');
    }
  }
}
