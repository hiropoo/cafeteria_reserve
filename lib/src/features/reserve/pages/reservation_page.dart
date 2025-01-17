import 'package:flutter/material.dart';
import 'package:sit_in_the_cafeteria/src/components/not_available_page.dart';

class ReservationPage extends StatelessWidget {
  const ReservationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // 位置情報を送信する画面
      body: Center(
        child: NotAvailablePage(),
      ),
    );
  }
}
