import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sit_in_the_cafeteria/src/components/my_container.dart';
import 'package:sit_in_the_cafeteria/src/features/auth/pages/user_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/profile/pages/friend_list_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/domain/reservation_state.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_confirm_page/no_reservation_page.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_confirm_page/penalty_page.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_confirm_page/reservation_confirm_page.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_notifier.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';

class MyPage extends ConsumerWidget {
  static final _dateFormatter = DateFormat('yyyy/MM/dd');
  static final _timeFormatter = DateFormat('HH:mm');

  const MyPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userNotifierProvider);
    final friendList = ref.watch(friendListNotifierProvider);

    final reservationState = ref.watch(reservationStateProvider);
    final reservation = ref.watch(reservationProvider);

    // 座席確認画面へ遷移
    void confirmSeat() {
      switch (reservation!.cafeNum) {
        case 1:
          context.goNamed(AppRoute.seat1.name, extra: reservation.seatNumbers.first);
          break;
        case 2:
          context.goNamed(AppRoute.seat2.name, extra: reservation.seatNumbers.first);
          break;
        default:
          break;
      }
    }

    return friendList.when(
      // フレンドリスト取得失敗
      error: (_, __) => Center(
        child: Text(
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          'エラーが発生しました',
        ),
      ),

      // フレンドリスト取得中
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),

      // フレンドリスト取得成功
      data: (friendList) {
        // 予約情報取得中
        if (reservationState == ReservationState.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // 予約情報取得成功
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Center(
              child: Column(
                children: [
                  // ユーザー情報
                  MyContainer(
                    child: Column(
                      children: [
                        // 名前
                        Text(
                          user.userName,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.secondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Divider(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ID
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    // クリップボードにコピー
                                    Clipboard.setData(
                                      ClipboardData(text: user.userID),
                                    );

                                    // スナックバー表示
                                    ScaffoldMessenger.of(context)
                                      ..removeCurrentSnackBar()
                                      ..showSnackBar(
                                        const SnackBar(
                                          content: Text('IDをコピーしました'),
                                        ),
                                      );
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'ID',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.secondary,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          user.userID,
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.secondary,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14,
                                            height: 2,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            // 友達の数
                            Material(
                              color: Colors.transparent,
                              child: Ink(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Theme.of(context).colorScheme.onSurface,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    // 友達一覧へ
                                    debugPrint('友達一覧へ');
                                    context.pushNamed(AppRoute.friendList.name);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          '友だち ',
                                          style: TextStyle(
                                            color: Theme.of(context).colorScheme.secondary,
                                            fontSize: 14,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              friendList.length.toString(),
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.secondary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 20,
                                              ),
                                            ),
                                            Text(
                                              '人',
                                              style: TextStyle(
                                                color: Theme.of(context).colorScheme.secondary,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Divider(
                            color: Theme.of(context).colorScheme.onSurface,
                          ),
                        ),

                        switch (reservationState) {
                          // 予約がない場合 -> 予約なし画面を表示
                          ReservationState.noReservation => const NoReservationPage(),

                          // 予約があり、まだ位置情報を送信していない場合 -> 位置情報送信画面を表示
                          ReservationState.hasReservation =>  ReservationConfirmPage(fromMyPage: true,),

                          // ペナルティがある場合 -> ペナルティ画面を表示
                          ReservationState.hasPenalty => const PenaltyPage(),

                          // ローディング中の場合
                          ReservationState.loading => const Center(
                              child: CircularProgressIndicator(),
                            ),

                          // エラーが発生した場合
                          ReservationState.error => Center(
                              child: Text(
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.secondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                'エラーが発生しました',
                              ),
                            ),
                        },
                      ],
                    ),
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
