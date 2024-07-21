import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sit_in_the_cafeteria/src/components/location_page_tile.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/components/my_container.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_notifier.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';

class ReservationConfirmPage extends ConsumerWidget {
  static final _dateFormatter = DateFormat('yyyy/MM/dd');
  static final _timeFormatter = DateFormat('HH:mm');

  final bool fromMyPage;

  const ReservationConfirmPage({super.key, this.fromMyPage = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservation = ref.watch(reservationProvider);

    // 座席確認画面へ遷移
    void confirmSeat() {
      switch (reservation!.cafeNum) {
        case 1:
          if (fromMyPage) {
            context.goNamed(AppRoute.profileSeat1.name, extra: reservation.seatNumbers.first);
          } else {
            context.goNamed(AppRoute.seat1.name, extra: reservation.seatNumbers.first);
          }
          break;
        case 2:
          if (fromMyPage) {
            context.goNamed(AppRoute.profileSeat2.name, extra: reservation.seatNumbers.first);
          } else {
            context.goNamed(AppRoute.seat2.name, extra: reservation.seatNumbers.first);
          }
          break;
        default:
          break;
      }
    }

    return MyContainer(
      child: Column(
        children: [
          const SizedBox(height: 10),

          // タイトル
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline_rounded,
                size: 30,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Text(
                '予約内容',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // 予約した学食
          LocationPageTile(
            header: '予約した学食',
            content: reservation!.cafeNum == 1 ? '第1食堂' : '第2食堂',
          ),

          const SizedBox(height: 10),

          // 予約日
          LocationPageTile(
            header: '予約日',
            content: _dateFormatter.format(reservation.startTime!),
          ),

          const SizedBox(height: 10),

          // 予約時間
          LocationPageTile(
            header: '予約時間',
            content: '${_timeFormatter.format(reservation.startTime!)} ~ ${_timeFormatter.format(reservation.endTime!)}',
          ),

          const SizedBox(height: 10),

          // 予約した座席
          LocationPageTile(header: '予約した座席', content: reservation.seatNumbers.map((seatNum) => seatNum).join(', ')),

          const SizedBox(height: 5),

          // 座席を確認
          GestureDetector(
            onTap: confirmSeat,
            child: Row(
              children: [
                Icon(
                  Icons.arrow_right_rounded,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(
                  "座席の確認はこちら",
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),

          if (fromMyPage) const SizedBox(height: 40),

          // 予約をキャンセルするボタン
          if (fromMyPage) MyButton(onPressed: () {}, child: Text('予約をキャンセルする')),
        ],
      ),
    );
  }
}
