import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';
import 'package:puebly/features/home/presentation/screens/home_screen.dart';
import 'package:puebly/features/home/presentation/widgets/webview_with_tabs.dart';

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showHomeScreen = ref.watch(showHomeScreenProvider);
    return SafeArea(
        child: Stack(
      children: [
        const WebViewWithTabs(),
        showHomeScreen ? const HomeScreen() : const SizedBox(),
      ],
    ));
  }
}
