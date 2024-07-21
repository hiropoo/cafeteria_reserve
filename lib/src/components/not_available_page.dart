import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/src/components/my_button.dart';
import 'package:sit_in_the_cafeteria/src/components/my_container.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';
import 'package:sit_in_the_cafeteria/src/router/bottom_nav_index_notifier.dart';

class NotAvailablePage extends ConsumerWidget {
  const NotAvailablePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: MyContainer(
        child: SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                'この機能は現在開発中です',
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 180,
                height: 180,
                child: Image.asset(
                  fit: BoxFit.cover,
                  'lib/src/assets/images/not-available.png',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              MyButton(
                onPressed: () {
                  ref.read(bottomNavIndexProvider.notifier).changeIndex(1);
                  context.pushReplacementNamed(AppRoute.location.name);
                },
                child: const Text(Strings.returnButton),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
