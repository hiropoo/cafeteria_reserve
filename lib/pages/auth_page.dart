import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sit_in_the_cafeteria/auth/auth_state.dart';
import 'package:sit_in_the_cafeteria/auth/auth_state_notifier.dart';
import 'package:sit_in_the_cafeteria/pages/login_page.dart';
import 'package:sit_in_the_cafeteria/pages/main_page.dart';
import 'package:sit_in_the_cafeteria/pages/sign_up_page.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateNotifierProvider);

    return Scaffold(
      body: authState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, stackTrace) {
          debugPrint(e.toString());
          // Schedule navigation after the current build cycle
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage()));
          });
          return const SizedBox.shrink(); // Return an empty widget for now
        },
        data: (authState) {
          debugPrint('authState: $authState');

          // Switch based on authState and schedule navigation similarly
          switch (authState) {
            case AuthState.loggedOut:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const LoginPage()));
              });
              break;
            case AuthState.signUp:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const SignUpPage()));
              });
              break;
            case AuthState.loggedIn:
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MainPage()));
              });
              break;
            default:
              // Handle unknown authState
              debugPrint('unknown authState: $authState');
          }
          return const SizedBox.shrink(); // Return an empty widget for now
        },
      ),
    );
  }
}
