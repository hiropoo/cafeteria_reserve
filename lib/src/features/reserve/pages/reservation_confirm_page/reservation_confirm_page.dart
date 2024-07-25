import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sit_in_the_cafeteria/src/components/location_page_tile.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/components/my_container.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_notifier.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';
import 'package:sit_in_the_cafeteria/src/utils/my_ui_feedback_manager.dart';

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
      HapticFeedback.selectionClick();

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
               Strings.reservationContent,
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
            header: Strings.reservationCafe,
            content: reservation!.cafeNum == 1 ? Strings.cafeteria1 : Strings.cafeteria2,
          ),

          const SizedBox(height: 10),

          // 予約日
          LocationPageTile(
            header: Strings.reservationDate,
            content: _dateFormatter.format(reservation.startTime!),
          ),

          const SizedBox(height: 10),

          // 予約時間
          LocationPageTile(
            header: Strings.reservationTime,
            content: '${_timeFormatter.format(reservation.startTime!)} ~ ${_timeFormatter.format(reservation.endTime!)}',
          ),

          const SizedBox(height: 10),

          // 予約した座席
          LocationPageTile(header: Strings.reservationSeat, content: reservation.seatNumbers.map((seatNum) => seatNum).join(', ')),

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
                  Strings.confirmSeat,
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
          if (fromMyPage)
            MyButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                MyUIFeedbackManager.showDialog(
                  context: context,
                  title: Strings.reservationCancel,
                  message: Strings.reservationCancelMessage,
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.pop();
                      },
                      child: const Text(Strings.no),
                    ),
                    TextButton(
                      onPressed: () {
                        context.pop();
                        // 予約のキャンセル
                        ref.read(reservationNotifierProvider.notifier).clear();
                      },
                      child: const Text(
                        style: TextStyle(
                          color: Colors.red,
                        ),
                        Strings.yes,
                      ),
                    ),
                  ],
                );
              },
              child: const Text(Strings.reservationCancel),
            ),
        ],
      ),
    );
  }
}
