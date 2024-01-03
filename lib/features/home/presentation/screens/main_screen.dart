import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';
import 'package:puebly/features/home/presentation/screens/home_screen.dart';
import 'package:puebly/features/home/presentation/screens/sections_screen.dart';
import 'package:puebly/features/home/presentation/widgets/webview_with_tabs.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showHomeScreen = ref.watch(showHomeScreenProvider);
    final showSectionsScreen = ref.watch(showSectionsScreenProvider);
    final showDialogBool = ref.watch(showDialogProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {

      if (!showDialogBool) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Hola'),
          content: const Text('Bienvenido'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                ref.read(dialogActivated.notifier).state = true;
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
    });

    return SafeArea(
        child: Stack(
      children: [
        const WebViewWithTabs(),
        showSectionsScreen ? const SectionsScreen() : const SizedBox(),
        showHomeScreen ? const HomeScreen() : const SizedBox(),
      ],
    ));
  }
}
