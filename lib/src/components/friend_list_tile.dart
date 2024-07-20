import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/features/profile/pages/friend_list_notifier.dart';

class FriendListTile extends ConsumerWidget {
  const FriendListTile({super.key, required this.friendID, required this.friendName});

  final String friendID;
  final String friendName;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendListNotifier = ref.read(friendListNotifierProvider.notifier);

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            backgroundColor: Colors.red,
            onPressed: (_) {
              // 削除処理
              friendListNotifier.deleteFriend(friendID);
            },
            icon: Icons.delete,
            label: '削除',
          ),
        ],
      ),
      child: Container(
        color: Colors.white,
        child: ListTile(
          title: Text(friendName),
          subtitle: Text(friendID),
        ),
      ),
    );
  }
}
