import 'package:flutter/material.dart';
import 'package:sit_in_the_cafeteria/src/components/my_drawer.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Page'),
      ),
      drawer: const MyDrawer(),
      body: const Center(
        child: Text('My Page'),
      ),
    );
  }
}
