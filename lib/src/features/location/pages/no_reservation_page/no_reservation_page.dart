import 'package:flutter/material.dart';

class NoReservationPage extends StatelessWidget {
  const NoReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('予約情報'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 20),
              Text(
                '予約がありません',
                style: TextStyle(
                  fontSize: 24,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 任意の処理をここに追加
                  Navigator.of(context).pop();
                },
                child: const Text('戻る'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
