import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/home/presentation/providers/scaffoldkey_provider.dart';
import 'package:puebly/features/home/presentation/webview_info.dart';

import 'notifiers/webview_notifier.dart';

final auxiliaryWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final webViewPath = ref.watch(auxiliaryWebViewPathProvider);
  return WebViewNotifier(
    webViewPath,
    scaffoldKey: scaffoldKey,
    context: context,
  );
});

final auxiliaryWebViewPathProvider =
    StateProvider<String>((ref) => 'app-comunidad');
