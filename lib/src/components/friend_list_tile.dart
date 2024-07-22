import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/features/profile/pages/friend_list_notifier.dart';
import 'package:sit_in_the_cafeteria/src/utils/my_ui_feedback_manager.dart';

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
              // iosダイアログの表示
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text('友だち削除'),
                  content: const Text('友だちを削除しますか?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('キャンセル'),
                    ),
                    TextButton(
                      onPressed: () {
                        // 削除処理
                        friendListNotifier.deleteFriend(friendID);

                        Navigator.pop(context);
                      },
                      child: const Text(
                        style: TextStyle(color: Colors.red),
                        '削除',
                      ),
                    ),
                  ],
                ),
              );
            },
            icon: Icons.delete,
            label: '削除',
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          // 友達のIDをコピー
          Clipboard.setData(ClipboardData(text: friendID));

          // スナックバー表示
          MyUIFeedbackManager.showSnackBar(
            context: context,
            content: const Text('IDをコピーしました'),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey,
                width: 0.5,
              ),
            ),
          ),
          height: 60,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
                friendName,
              ),
              Text('ID  $friendID'),
            ],
          ),
        ),
      ),
    );
  }
}
