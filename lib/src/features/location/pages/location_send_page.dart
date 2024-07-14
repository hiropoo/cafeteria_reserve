import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sit_in_the_cafeteria/src/components/location_page_tile.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/features/location/domains/location_state.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/location_state_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/seat_page.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_notifier.dart';

class LocationSendPage extends HookConsumerWidget {
  static final _dateFormatter = DateFormat('yyyy/MM/dd');
  static final _timeFormatter = DateFormat('HH:mm');

  const LocationSendPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = useState<String>(" ");

    ref.listen<AsyncValue<LocationState>>(locationStateNotifierProvider, (prev, state) {
      state.when(
        data: (state) {
          switch (state) {
            case LocationState.timeError:
              errorMessage.value = Strings.timeError;
              break;
            case LocationState.locationError:
              errorMessage.value = Strings.locationError;
              break;
            case LocationState.connectionError:
              errorMessage.value = Strings.connectionError;
              break;
            default:
              errorMessage.value = " ";
          }
        },
        loading: () => errorMessage.value = " ",
        error: (e, _) => errorMessage.value = " ",
      );
    });

    final locationState = ref.watch(locationStateNotifierProvider);
    final locationStateNotifier = ref.read(locationStateNotifierProvider.notifier);
    final reservation = ref.watch(reservationProvider);

    if (reservation == null) {
      return const Scaffold(
        body: Center(child: Text('予約情報が見つかりません')),
      );
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    // 予約した学食
                    LocationPageTile(
                      header: '予約した学食',
                      content: reservation.cafeNum == 1 ? '第1食堂' : '第2食堂',
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

                    // 座席を確認
                    GestureDetector(
                      onTap: () {
                        // 座席確認画面に遷移
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SeatPage()));
                      },
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
                  ],
                ),
              ),

              // 説明
              Text(
                Strings.locationDescription,
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),

              // エラーメッセージ表示部分
              if (errorMessage.value.isNotEmpty)
                Text(
                  errorMessage.value,
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 12,
                  ),
                ),

              // 位置情報を送信するボタン
              MyButton(
                onPressed: () async {
                  // 位置情報を更新
                  locationStateNotifier.updateArrived();
                },
                child: locationState.maybeWhen(
                  orElse: () => const Text('位置情報を送信'),
                  loading: () => const CircularProgressIndicator(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
