import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

final indexWebViewProvider = StateProvider<int>((ref) => 0);

WebViewController _buildWebviewController(Uri webViewURL) {
  final controller = WebViewController();
  controller
    ..loadRequest(webViewURL)
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.white);
  return controller;
}

final employmentWebviewControllerProvider =
    StateProvider<WebViewController>((ref) {
  final webViewURL = Uri.parse('${EnviromentConstants.homeURL}/app-empleo');
  return _buildWebviewController(webViewURL);
});

final tourismWebviewControllerProvider =
    StateProvider<WebViewController>((ref) {
  final webViewURL = Uri.parse('${EnviromentConstants.homeURL}/app-turismo');
  return _buildWebviewController(webViewURL);
});

final commerceWebviewControllerProvider =
    StateProvider<WebViewController>((ref) {
  final webViewURL = Uri.parse('${EnviromentConstants.homeURL}/app-comercio');
  return _buildWebviewController(webViewURL);
});

final marketWebviewControllerProvider = StateProvider<WebViewController>((ref) {
  final webViewURL = Uri.parse('${EnviromentConstants.homeURL}/app-plaza');
  return _buildWebviewController(webViewURL);
});

final webViewControllerProviders = Provider<List<WebViewController>>((ref) {
  return [
    ref.watch(commerceWebviewControllerProvider),
    ref.watch(employmentWebviewControllerProvider),
    ref.watch(marketWebviewControllerProvider),
    ref.watch(tourismWebviewControllerProvider),
  ];
});

final totalWebViewsProvider = Provider<int>((ref) {
  final webViews = ref.watch(webViewControllerProviders);
  return webViews.length;
});
