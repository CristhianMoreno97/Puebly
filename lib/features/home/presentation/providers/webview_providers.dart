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
  return WebViewNotifier('app-comercio/?_categories=$town%2Ccomercio',
      scaffoldKey: scaffoldKey, context: context);
});

final employmentWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  return WebViewNotifier('app-empleo/?_categories=$town%2Cempleo',
      scaffoldKey: scaffoldKey, context: context);
});

final marketWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  return WebViewNotifier('app-plaza/?_categories=$town%2Cplaza',
      scaffoldKey: scaffoldKey, context: context);
});

final tourismWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  return WebViewNotifier('app-turismo/?_categories=$town%2Cturismo',
      scaffoldKey: scaffoldKey, context: context);
});

final classifiedWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  return WebViewNotifier('app-clasificados/?_categories=$town%2Cclasificados',
      scaffoldKey: scaffoldKey, context: context);
});

final communityWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  return WebViewNotifier('app-comunidad/?_categories=$town%2Ccomunidad',
      scaffoldKey: scaffoldKey, context: context);
});

final curiositiesWebViewProvider =
    StateNotifierProvider.family<WebViewNotifier, WebViewInfo, BuildContext>(
        (ref, context) {
  final scaffoldKey = ref.watch(scaffoldKeyProvider);
  final town = ref.watch(townParameter);
  return WebViewNotifier('app-sabias-que/?_categories=$town%2Csabias-que',
      scaffoldKey: scaffoldKey, context: context);
});

final townParameter = StateProvider<String>((ref) => 'boyaca-boyacaboyaca');
final townNameProvider = StateProvider<String>((ref) => 'Boyacá');
final sectionParameter = StateProvider<String>((ref) => 'comercio');

final indexWebViewProvider = StateProvider<int>((ref) => 0);
