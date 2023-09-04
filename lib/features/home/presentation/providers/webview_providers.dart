import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

final employmentWebviewControllerProvider =
    StateProvider<WebViewController>((ref) {
  return _buildWebviewController('/app-empleo');
});

final tourismWebviewControllerProvider =
    StateProvider<WebViewController>((ref) {
  return _buildWebviewController('/app-turismo');
});

final commerceWebviewControllerProvider =
    StateProvider<WebViewController>((ref) {
  return _buildWebviewController('/app-comercio');
});

final marketWebviewControllerProvider =
    StateProvider<WebViewController>((ref) {
  return _buildWebviewController('/app-plaza');
});

WebViewController _buildWebviewController(String webViewPath) {
  final webViewUrl = Uri.parse('${EnviromentConstants.webUrl}$webViewPath');
  final WebViewController controller = WebViewController();
  controller
    ..loadRequest(webViewUrl)
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white);
  return controller;
}

final indexWebViewProvider = StateProvider<int>((ref) => 0);

final pageControllerProvider =
    StateProvider<PageController>((ref) => PageController());
