import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/features/location/domains/location_state.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/send_page/location_state_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/reserve/pages/reservation_confirm_page/reservation_confirm_page.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';

class LocationSendPage extends HookConsumerWidget {
  const LocationSendPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final errorMessage = useState<String>(" ");
    final locationState = ref.watch(locationStateNotifierProvider);
    final locationStateNotifier = ref.read(locationStateNotifierProvider.notifier);

    // 位置情報送信の状態を監視
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
            case LocationState.permissionError:
              errorMessage.value = Strings.permissionError;
              break;

            case LocationState.locationSent:
              errorMessage.value = " ";

              // ページ遷移
              context.pushNamed(AppRoute.sendResult.name);
              break;
            default:
              errorMessage.value = " ";
          }
        },
        loading: () => errorMessage.value = " ",
        error: (e, _) => errorMessage.value = " ",
      );
    });

    // ボタンが押された時の位置情報送信処理
    Future sendArrived() async {
      HapticFeedback.lightImpact();

      // 位置情報を更新
      final result = await locationStateNotifier.updateArrived();
      if (result && context.mounted) {
        // 位置情報送信に成功したことを表示する画面へ遷移
        context.pushReplacementNamed(AppRoute.sendResult.name);
      }
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          50,
          20,
          50,
          30,
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const ReservationConfirmPage(),

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
                onPressed: sendArrived,
                child: locationState.maybeWhen(
                  orElse: () => const Text(Strings.locationSend),
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
