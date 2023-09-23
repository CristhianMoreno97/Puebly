import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:puebly/features/home/presentation/webview_info.dart';
import 'package:puebly/utils/utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewNotifier extends StateNotifier<WebViewInfo> {
  final String path;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;

  WebViewNotifier(
    this.path, {
    required this.scaffoldKey,
    required this.context,
  }) : super(WebViewInfo(path, scaffoldKey: scaffoldKey, context: context)) {
    _buildWebViewController();
  }

  void _setLoadingProgress(int progress) {
    state = state.copyWith(loadingProgress: progress);
  }

  NavigationDecision _controllerNavigationDecision(String url) {
    if (url.contains('puebly.com')) {
      return NavigationDecision.navigate;
    } else if (url.contains('api.whatsapp.com')) {
      Utils.launchWhatsapp(
        context,
        scaffoldKey,
        message: 'Hola Puebly, ',
      );
    } else {
      Utils.showSnackBar(
        context,
        scaffoldKey,
        'No se puede abrir la página $url',
        backgroundColor: Colors.red,
      );
    }

    return NavigationDecision.prevent;
  }

  NavigationDelegate _controllerNavigationDelegate() {
    return NavigationDelegate(
      onNavigationRequest: (request) {
        return _controllerNavigationDecision(request.url);
      },
      onPageStarted: (url) {
        _setLoadingProgress(0);
      },
      onPageFinished: (url) {
        _setLoadingProgress(100);
      },
      onProgress: (progress) {
        _setLoadingProgress(progress);
      },
    );
  }

  void _buildWebViewController() {
    final webViewURL =
        Uri.parse('${EnviromentConstants.homeURL}/${state.path}');
    final controller = WebViewController();
    controller
      ..loadRequest(webViewURL)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(_controllerNavigationDelegate());
    state = state.copyWith(
      controller: controller,
    );
  }
}
