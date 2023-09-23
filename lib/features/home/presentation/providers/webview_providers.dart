import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/home/presentation/providers/scaffoldkey_provider.dart';
import 'package:puebly/features/home/presentation/webview_info.dart';

import 'notifiers/webview_notifier.dart';

final commerceWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  return WebViewNotifier('/app-comercio',
      scaffoldKey: scaffoldKey, context: context);
});

final employmentWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  return WebViewNotifier('/app-empleo',
      scaffoldKey: scaffoldKey, context: context);
});

final marketWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  return WebViewNotifier('/app-plaza',
      scaffoldKey: scaffoldKey, context: context);
});

final tourismWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  return WebViewNotifier('/app-turismo',
      scaffoldKey: scaffoldKey, context: context);
});

final indexWebViewProvider = StateProvider<int>((ref) => 0);
