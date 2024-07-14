import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_drawer.dart';
import 'package:sit_in_the_cafeteria/src/features/location/domains/location_state.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/location_send_page.dart';
import 'package:sit_in_the_cafeteria/src/features/location/pages/location_state_notifier.dart';

class LocationBasePage extends ConsumerWidget {
  const LocationBasePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationState = ref.watch(locationStateNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          "位置情報を送信",
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        // ドロワーメニューを開くボタン
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: const MyDrawer(),

      // 位置情報送信画面
      body: locationState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stackTrace) {
          debugPrint(e.toString());
          return const Center(child: Text('エラーが発生しました'));
        },
        data: (locationState) {
          switch (locationState) {
            // 予約がない場合
            case LocationState.noReservation:
              return Center(
                child: Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  '予約がありません',
                ),
              );

            // 予約があり、まだ位置情報を送信していない場合 => 位置情報送信画面を表示
            case LocationState.locationNotSent:
              return const LocationSendPage();

            // 位置情報を送信した場合 => 送信完了画面を表示
            case LocationState.locationSent:
              return const Center(child: Text('位置情報を送信しました'));

            // エラーが発生した場合
            case LocationState.error:
              return Center(
                child: Text(
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  'エラーが発生しました',
                ),
              );
          }
        },
      ),
    );
  }
}
