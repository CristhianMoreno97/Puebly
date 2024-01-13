import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/towns/presentation/providers/webview_providers.dart';
import 'package:puebly/features/towns/presentation/widgets/custom_appbar.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends ConsumerWidget {
  const WebViewScreen({super.key});

  NavigationDelegate _navigationDelegate(WidgetRef ref) {
    return NavigationDelegate(
      onNavigationRequest: (request) {
        final uri = Uri.parse(request.url);
        if (uri.host == 'puebly.com') {
          return NavigationDecision.navigate;
        }
        return NavigationDecision.prevent;
      },
      onProgress: (progress) {
        ref.read(webViewIsLoadingProvider.notifier).state = true;
      },
      onPageFinished: (url) {
        ref.read(webViewIsLoadingProvider.notifier).state = false;
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final path = ref.watch(webViewPathProvider);
    final uri = Uri.parse('${EnviromentConstants.homeURL}/$path');

    return Scaffold(
      appBar: const CustomAppBar(showMenu: false),
      body: Stack(
        children: [
          WebViewWidget(
            controller: WebViewController()
              ..loadRequest(uri)
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setBackgroundColor(Colors.white)
              ..setNavigationDelegate(_navigationDelegate(ref)),
          ),
          const _LoadingProgress(),
        ],
      ),
    );
  }
}

class _LoadingProgress extends ConsumerWidget {
  const _LoadingProgress();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(webViewIsLoadingProvider);
    return isLoading
        ? Column(
            children: [
              const LinearProgressIndicator(
                color: ColorManager.colorSeed,
                backgroundColor: Colors.white,
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/puebly-loader.gif',
                    width: double.infinity,
                  ),
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
