import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sit_in_the_cafeteria/src/components/my_drawer.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
import 'package:sit_in_the_cafeteria/src/features/settings/pages/theme_notifier.dart';
import 'package:sit_in_the_cafeteria/src/features/settings/pages/use_mobile_theme.dart';
import 'package:sit_in_the_cafeteria/src/router/app_router.dart';

class SettingsPage extends HookConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ダークモードのオンオフ
    // 端末の設定を使うかどうか
    final isDarkMode = ref.watch(myThemeProvider).asData?.value.brightness == Brightness.dark;
    final useDeviceSetting = ref.watch(useMobileThemeProvider).asData?.value;

    // アプリのバージョンを取得
    final fromPlatform = useMemoized(PackageInfo.fromPlatform);
    final snapshot = useFuture(fromPlatform);
    if (!snapshot.hasData) {
      return const SizedBox.shrink();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          Strings.settings,
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
              icon: const Icon(Icons.keyboard_double_arrow_left_sharp),
              onPressed: () {
                context.pop();
              },
            );
          },
        ),
      ),
      drawer: const MyDrawer(),
      body: SettingsList(
        platform: DevicePlatform.iOS,
        sections: [
          SettingsSection(
            title: const Text(Strings.theme),
            tiles: [
              SettingsTile.switchTile(
                leading: const Icon(Icons.brightness_4),
                title: const Text(Strings.darkMode),
                initialValue: isDarkMode,
                onToggle: (value) {
                  ref.read(myThemeProvider.notifier).toggleTheme();
                },
              ),
              SettingsTile.switchTile(
                leading: const Icon(Icons.mobile_friendly_rounded),
                title: const Text(Strings.useMobileMode),
                initialValue: useDeviceSetting,
                onToggle: (value) {
                  ref.read(useMobileThemeProvider.notifier).toggleUseMobileTheme();
                },
              ),
            ],
          ),
          SettingsSection(
            title: const Text(Strings.network),
            tiles: [
              SettingsTile.navigation(
                leading: const Icon(Icons.admin_panel_settings_rounded),
                title: const Text(Strings.networkSetting),
                trailing: const Icon(color: Colors.grey, Icons.keyboard_arrow_right),
                onPressed: (context) => context.pushNamed(AppRoute.network.name),
              ),
            ],
          ),

          // アプリのバージョン
          SettingsSection(
            title: const Text(Strings.aboutApp),
            tiles: <SettingsTile>[
              SettingsTile(
                leading: const Icon(Icons.info),
                title: const Text(Strings.appVersion),
                value: Text("${snapshot.data?.version}"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
