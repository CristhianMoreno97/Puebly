import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/constants/enviroment_constants.dart';
import 'package:puebly/features/home/presentation/webview_info.dart';
import 'package:puebly/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewNotifier extends StateNotifier<WebViewInfo> {
  final String path;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final BuildContext context;
  final bool forceBuildWebviewController;
  final Function() buildNextWebViewController;

  WebViewNotifier(
    this.path, {
    required this.scaffoldKey,
    required this.context,
    required this.forceBuildWebviewController,
    required this.buildNextWebViewController,
  }) : super(WebViewInfo(path, scaffoldKey: scaffoldKey, context: context)) {
    if (forceBuildWebviewController) {
      buildWebViewController();
    }
  }

  get loadingProgress => state.loadingProgress;

  void _setLoadingProgress(int progress) {
    state = state.copyWith(loadingProgress: progress);
  }

  launchLinkApp({required Uri url}) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
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
    } else if (url.contains('tel:')) {
      Utils.launchPhoneCall(
        context,
        scaffoldKey,
        Uri.parse(url),
      );
    } else if (url.contains('https://www.google.com/maps/') ||
        url.contains('https://www.google.com.co/maps')) {
      launchLinkApp(url: Uri.parse(url));
    } else {
      return NavigationDecision.navigate;
      /*
      Utils.showSnackBar(
        context,
        scaffoldKey,
        'No se puede abrir la página $url',
        backgroundColor: Colors.red,
      );*/
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
        if (!state.loaded) {
          buildNextWebViewController();
          state = state.copyWith(loaded: true);
        }
      },
      onProgress: (progress) {
        _setLoadingProgress(progress);
      },
    );
  }

  void buildWebViewController() {
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
