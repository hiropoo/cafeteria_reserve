import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sit_in_the_cafeteria/src/utils/my_ui_feedback_manager.dart';
import 'package:sit_in_the_cafeteria/src/utils/repository.dart';

class NetworkSettingPage extends HookConsumerWidget {
  const NetworkSettingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ipTextController = useTextEditingController(text: Repository.serverIP);
    final portTextController = useTextEditingController(text: Repository.serverPort.toString());
    final ip = useState(Repository.serverIP);
    final port = useState(Repository.serverPort.toString());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'ネットワーク設定',
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
      body: SettingsList(
        sections: [
          SettingsSection(
            title: const Text('サーバ設定'),
            tiles: [
              SettingsTile(
                title: const Text('IPアドレス'),
                value: Text(ip.value),
                onPressed: (context) {
                  MyUIFeedbackManager.showTextFieldDialog(
                    controller: ipTextController,
                    context: context,
                    title: 'IPアドレス',
                    message: 'IPアドレスを入力してください',
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          'キャンセル',
                          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                          Repository.serverIP = ipTextController.text;
                          ip.value = ipTextController.text;
                          ipTextController.clear();
                        },
                        child: const Text('保存'),
                      ),
                    ],
                  );
                },
              ),
              SettingsTile(
                title: const Text('ポート番号'),
                value: Text(port.value),
                onPressed: (context) {
                  MyUIFeedbackManager.showTextFieldDialog(
                    isNumber: true,
                    controller: portTextController,
                    context: context,
                    title: 'ポート番号',
                    message: 'ポート番号を入力してください',
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          'キャンセル',
                          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          context.pop();
                          Repository.serverPort = int.parse(portTextController.text);
                          port.value = portTextController.text;
                          portTextController.clear();
                        },
                        child: const Text('保存'),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
