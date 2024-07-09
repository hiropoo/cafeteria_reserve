import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String title;
  final IconData? icon;
  final void Function()? onTap;

  const MyDrawerTile({super.key, required this.title, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Icon(
          icon,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
      onTap: onTap,
    );
  }
}
