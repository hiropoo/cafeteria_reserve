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
        return Friend(friendID: friend[0], friendName: friend[1]);
      }).toList();

      debugPrint('fetchFriendList success');

      return friendList;
    } else {
      debugPrint('unknown response from server');
      return Future.error('unknown response from server');
    }
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
