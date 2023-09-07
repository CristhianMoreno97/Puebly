import 'package:flutter/material.dart';
import 'package:puebly/features/home/presentation/widgets/webview_with_tabs.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(child: WebViewWithTabs());
  }
}
