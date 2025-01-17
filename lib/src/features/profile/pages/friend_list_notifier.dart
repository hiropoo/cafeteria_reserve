import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/user_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/profile/data/friend_list_repository.dart';
import 'package:sit_in_the_cafeteria/src/features/profile/domain/friend.dart';

part 'friend_list_notifier.g.dart';

@riverpod
class FriendListNotifier extends _$FriendListNotifier {
  @override
  Future<List<Friend>> build() async {
    final repository = ref.read(friendListRepositoryProvider);
    final user = ref.watch(userNotifierProvider);

    final friendList = await repository.fetchFriendList(userID: user.userID);

    return friendList;
  }

  // フレンド削除
  void deleteFriend(String friendID) async {
    final currentState = state;

    state = const AsyncLoading();

    final repository = ref.read(friendListRepositoryProvider);
    final user = ref.watch(userNotifierProvider);

    final result = await repository.removeFriend(userID: user.userID, friendID: friendID);
    await Future.delayed(const Duration(seconds: 1));

    if (result) {
      final friendList = await repository.fetchFriendList(userID: user.userID);
      state = AsyncData(friendList);
    } else {
      state = currentState;
    }
  }

  // フレンド追加
  void addFriend(String friendID) async {
    final currentState = state;

    state = const AsyncLoading();
    final repository = ref.read(friendListRepositoryProvider);
    final user = ref.watch(userNotifierProvider);

    final result = await repository.addFriend(userID: user.userID, friendID: friendID);
    await Future.delayed(const Duration(seconds: 1));

    if (result) {
      final friendList = await repository.fetchFriendList(userID: user.userID);
      state = AsyncData(friendList);
    } else {
      state = currentState;
    }
  }

  // リフレッシュ
  Future refresh() async {
    state = const AsyncLoading();

    final friendList = await ref.read(friendListRepositoryProvider).fetchFriendList(userID: ref.read(userNotifierProvider).userID);

    state = AsyncData(friendList);
  }
}
