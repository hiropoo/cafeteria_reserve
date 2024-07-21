import 'package:flutter/material.dart';
import 'package:sit_in_the_cafeteria/src/components/my_app_bar.dart';
import 'package:sit_in_the_cafeteria/src/components/not_available_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: MyAppBar(
        title: '設定',
      ),
      body: Center(
        child: NotAvailablePage(),
      ),
    );
  }
}
