import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/profile/domain/friend.dart';
import 'package:sit_in_the_cafeteria/src/utils/repository.dart';

part 'friend_list_repository.g.dart';

@riverpod
FriendListRepository friendListRepository(FriendListRepositoryRef ref) => FriendListRepository();

class FriendListRepository extends Repository {
  FriendListRepository();

  /// フレンドリスト取得処理
  /// request -> "fetchFriend userID"
  /// response -> "success userID1:userName1 userID2:userName2 ..." or "failure message"
  Future<List<Friend>> fetchFriendList({required String userID}) async {
    await Future.delayed(const Duration(seconds: 1));

    debugPrint('fetchFriendList method called');

    // サーバに通信してフレンドリスト取得処理を行う
    await connect();
    final response = await request("fetchFriend $userID");

    final List<String> responseList = response.split(" ");

    // フレンドリスト取得失敗時
    if (responseList.first == "failure") {
      if (responseList[1] == "noData") {
        debugPrint('fetchFriend failed : noData');
        return [];
      }
      final message = responseList[1];
      debugPrint('fetchFriend failed : $message');
      return [];
    }

    // フレンドリスト取得成功時
    // userID1:userName1 userID2:userName2 ... をList<Friend>に変換して返す
    else if (responseList.first == "success") {
      final friendList = responseList.sublist(1).map((friendString) {
        final friend = friendString.split(":");
        final friendID = friend[0];
        // 名前に\nが含まれている場合は削除
        final friendName = friend[1].replaceAll("\n", "");
        return Friend(friendID: friendID, friendName: friendName);
      }).toList();

      debugPrint('fetchFriendList success');

      return friendList;
    } else {
      debugPrint('unknown response from server');
      return Future.error('unknown response from server');
    }
  }

  /// フレンド追加処理
  /// request -> "addFriend userID friendID"
  /// response -> "success friendID:friendName" or "failure message"
  Future<bool> addFriend({required String userID, required String friendID}) async {
    bool isSuccess = false;
    debugPrint('addFriend method called');

    // サーバに通信してフレンド追加処理を行う
    await connect();
    final response = await request("addFriend $userID $friendID");

    final List<String> responseList = response.split(" ");

    // フレンド追加失敗時
    if (responseList.first == "failure") {
      final message = responseList[1];
      debugPrint('addFriend failed : $message');
    }
    // フレンド追加成功時
    else if (responseList.first == "success") {
      isSuccess = true;
      debugPrint('addFriend success');
    } else {
      debugPrint('unknown response from server');
    }

    return isSuccess;
  }

  /// フレンド削除処理
  /// request -> "removeFriend userID friendID"
  /// response -> "success" or "failure message"
  Future<bool> removeFriend({required String userID, required String friendID}) async {
    bool isSuccess = false;
    debugPrint('removeFriend method called');

    // サーバに通信してフレンド削除処理を行う
    await connect();
    final response = await request("removeFriend $userID $friendID");

    final List<String> responseList = response.split(" ");

    // フレンド削除失敗時
    if (responseList.first == "failure") {
      final message = responseList[1];
      debugPrint('removeFriend failed : $message');
    }
    // フレンド削除成功時
    else if (responseList.first == "success") {
      isSuccess = true;
      debugPrint('removeFriend success');
    } else {
      debugPrint('unknown response from server');
    }

    return isSuccess;
  }
}
