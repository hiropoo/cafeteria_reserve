import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/friend_list_tile.dart';
import 'package:sit_in_the_cafeteria/src/components/friend_text_field.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/components/my_container.dart';
import 'package:sit_in_the_cafeteria/src/features/profile/pages/friend_list_notifier.dart';

class FriendListPage extends HookConsumerWidget {
  const FriendListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final friendList = ref.watch(friendListNotifierProvider);
    final friendController = useTextEditingController();
    final friendListNotifier = ref.read(friendListNotifierProvider.notifier);

    return friendList.when(
      loading: () {
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
      error: (error, stackTrace) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('エラーが発生しました'),
              const SizedBox(height: 50),
              MyButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text('戻る'),
              ),
            ],
          ),
        ),
      ),
      data: (friendList) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 10),
            child: MyContainer(
              child: Column(
                children: [
                  // タイトル
                  Text(
                    'すべての友だち',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                  Divider(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),

                  // 友達追加
                  Row(
                    children: [
                      Expanded(
                        child: FriendTextField(
                          controller: friendController,
                        ),
                      ),
                      SizedBox(
                        width: 80,
                        child: MyButton(
                          onPressed: () {
                            // 友達追加処理
                            friendListNotifier.addFriend(friendController.text);
                            friendController.clear();
                          },
                          child: const Text('追加'),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // フレンドリスト
                  Expanded(
                    child: ListView.builder(
                      itemCount: friendList.length,
                      itemBuilder: (context, index) {
                        final friend = friendList[index];

                        return FriendListTile(
                          friendID: friend.friendID,
                          friendName: friend.friendName,
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 戻るボタン
                  MyButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('戻る'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
