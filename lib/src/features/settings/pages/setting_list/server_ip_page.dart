import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:sit_in_the_cafeteria/src/constant/strings.dart';
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
          Strings.networkSetting,
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
            title: const Text(Strings.serverSetting),
            tiles: [
              SettingsTile(
                title: const Text(Strings.ip),
                value: Text(ip.value),
                onPressed: (context) {
                  MyUIFeedbackManager.showTextFieldDialog(
                    controller: ipTextController,
                    context: context,
                    title: Strings.ip,
                    message: Strings.ipMessage,
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          Strings.cancel,
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
                        child: const Text(Strings.save),
                      ),
                    ],
                  );
                },
              ),
              SettingsTile(
                title: const Text(Strings.port),
                value: Text(port.value),
                onPressed: (context) {
                  MyUIFeedbackManager.showTextFieldDialog(
                    isNumber: true,
                    controller: portTextController,
                    context: context,
                    title: Strings.port,
                    message: Strings.portMessage,
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text(
                          Strings.cancel,
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
                        child: const Text(Strings.save),
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
