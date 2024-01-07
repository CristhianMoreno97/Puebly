import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/features/home/presentation/providers/scaffoldkey_provider.dart';
import 'package:puebly/features/home/presentation/webview_info.dart';

import 'notifiers/webview_notifier.dart';

final commerceWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  final forceBuildWebviewController = town != null;
  final nextWebviewController = ref.watch(employmentWebViewProvider(context).notifier).buildWebViewController;
  return WebViewNotifier('app-comercio/?_categories=$town%2Ccomercio',
      scaffoldKey: scaffoldKey, context: context, forceBuildWebviewController: forceBuildWebviewController, buildNextWebViewController: nextWebviewController);
});

final employmentWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  final nextWebviewController = ref.watch(marketWebViewProvider(context).notifier).buildWebViewController;
  return WebViewNotifier('app-empleo/?_categories=$town%2Cempleo',
      scaffoldKey: scaffoldKey, context: context, forceBuildWebviewController: false, buildNextWebViewController: nextWebviewController);
});

final marketWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  final nextWebviewController = ref.watch(tourismWebViewProvider(context).notifier).buildWebViewController;
  return WebViewNotifier('app-plaza/?_categories=$town%2Cplaza',
      scaffoldKey: scaffoldKey, context: context, forceBuildWebviewController: false, buildNextWebViewController: nextWebviewController);
});

final tourismWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  final nextWebviewController = ref.watch(classifiedWebViewProvider(context).notifier).buildWebViewController;
  return WebViewNotifier('app-turismo/?_categories=$town%2Cturismo',
      scaffoldKey: scaffoldKey, context: context, forceBuildWebviewController: false, buildNextWebViewController: nextWebviewController);
});

final classifiedWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  final nextWebviewController = ref.watch(communityWebViewProvider(context).notifier).buildWebViewController;
  return WebViewNotifier('app-clasificados/?_categories=$town%2Cclasificados',
      scaffoldKey: scaffoldKey, context: context, forceBuildWebviewController: false, buildNextWebViewController: nextWebviewController);
});

final communityWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  final nextWebviewController = ref.watch(curiositiesWebViewProvider(context).notifier).buildWebViewController;
  return WebViewNotifier('app-comunidad/?_categories=$town%2Ccomunidad',
      scaffoldKey: scaffoldKey, context: context, forceBuildWebviewController: false, buildNextWebViewController: nextWebviewController);
});

final curiositiesWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  return WebViewNotifier('app-sabias-que/?_categories=$town%2Csabias-que',
      scaffoldKey: scaffoldKey, context: context, forceBuildWebviewController: false, buildNextWebViewController: (){});
});

final townParameter = StateProvider<String?>((ref) => null);
final townNameProvider = StateProvider<String>((ref) => 'Boyacá');
final sectionParameter = StateProvider<String>((ref) => 'comercio');

final indexWebViewProvider = StateProvider<int>((ref) => 0);
