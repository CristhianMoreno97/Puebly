import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/providers/auxiliary_webview_providers.dart';
import 'package:puebly/features/home/presentation/widgets/appbar_title.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AuxiliaryScreen extends ConsumerWidget {
  const AuxiliaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webView = ref.watch(auxiliaryWebViewProvider(context));
    if (webView.controller == null) {
      return const Center(
          child: CircularProgressIndicator(
        color: Colors.green,
        strokeWidth: 8,
      ));
    }
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette1.color1,
          title: const AppBarTitle(),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: webView.loadingProgress < 100
            ? const Center(
                child: CircularProgressIndicator(
                color: Colors.green,
                strokeWidth: 8,
              ))
            : WebViewWidget(controller: webView.controller!),
      ),
    );
  }
}
