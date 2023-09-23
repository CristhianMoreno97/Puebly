import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/providers/page_controller_provider.dart';
import 'package:puebly/features/home/presentation/providers/scaffoldkey_provider.dart';
import 'package:puebly/features/home/presentation/providers/webview_providers.dart';
import 'package:puebly/features/home/presentation/widgets/appbar_title.dart';
import 'package:puebly/features/home/presentation/widgets/custom_drawer.dart';
import 'package:puebly/features/home/presentation/widgets/custom_tab_item.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWithTabs extends ConsumerWidget {
  const WebViewWithTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey = ref.watch(scaffoldKeyProvider);
    final webViews = [
      ref.watch(commerceWebViewProvider(context)),
      ref.watch(tourismWebViewProvider(context)),
      ref.watch(marketWebViewProvider(context)),
      ref.watch(employmentWebViewProvider(context)),
    ];

    const tabGradientColors = LinearGradient(colors: [
      ColorPalette1.color1,
      ColorPalette1.color1a,
    ]);

    final tabs = [
      TabInfo(
        'Comercio',
        Icons.storefront_outlined,
        Icons.storefront_rounded,
        tabGradientColors,
      ),
      TabInfo(
        'Turismo',
        Icons.place_outlined,
        Icons.place_rounded,
        tabGradientColors,
      ),
      TabInfo(
        'Plaza',
        Icons.shopping_basket_outlined,
        Icons.shopping_basket_rounded,
        tabGradientColors,
      ),
      TabInfo(
        'Empleo',
        Icons.work_outline_outlined,
        Icons.work_outlined,
        tabGradientColors,
      ),
    ];

    final menuButton = IconButton(
      padding: const EdgeInsets.all(8),
      visualDensity: VisualDensity.compact,
      icon: const Icon(
        Icons.menu,
        size: 40,
        color: Colors.white,
      ),
      onPressed: () {
        ref.read(scaffoldKeyProvider.notifier).drawerOpener(context);
      },
      // TODO: difinir estilo del boton en un archivo de tema, por ejemplo: app_theme.dart
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );

    final appBarLeading = Row(
      children: [
        const SizedBox(width: 8),
        menuButton,
      ],
    );

    final appBar = AppBar(
      backgroundColor: ColorPalette1.color1,
      toolbarHeight: 64,
      title: const AppBarTitle(),
      leadingWidth: 64,
      leading: appBarLeading,
    );

    void goToWebView(int index) {
      final pageController = ref.watch(pageControllerProvider);
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }

    final bottomAppBar = BottomAppBar(
      color: Colors.white,
      surfaceTintColor: Colors.green,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int index = 0; index < webViews.length; index++)
            CustomTabItem(
              tabInfo: tabs[index],
              isSelected: index == ref.watch(indexWebViewProvider),
              onTap: () => goToWebView(index),
            ),
        ],
      ),
    );

    Future<bool> willPopAction() async {
      final indexWebView = ref.read(indexWebViewProvider);
      final currentWebView = webViews[indexWebView];

      if (currentWebView.controller == null) {
        return true;
      }

      if (await currentWebView.controller!.canGoBack()) {
        currentWebView.controller!.goBack();
        return false;
      }

      if (context.mounted) {
        bool confirmExit = await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: const Text('Confirmar salida'),
            content: const Text('¿Estás seguro de que deseas salir?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // No salir
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Salir
                },
                child: const Text('Aceptar'),
              ),
            ],
          ),
        );
        return confirmExit;
      }
      return false;
    }

    PageView buidPageView() {
      final pageController = ref.watch(pageControllerProvider);

      return PageView.builder(
        controller: pageController,
        itemCount: webViews.length,
        itemBuilder: (context, index) {
          if (webViews[index].controller == null) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 8,
            ));
          }
          if (webViews[index].loadingProgress < 100) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 8,
            ));
          }
          // Esperar a que el webview renderize la nueva carga
          Future.delayed(const Duration(milliseconds: 100));
          final webView = WebViewWidget(
              controller: webViews[index].controller as WebViewController);
          return webView;
        },
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) =>
            ref.read(indexWebViewProvider.notifier).state = index,
      );
    }

    return Scaffold(
      key: scaffoldKey,
      appBar: appBar,
      body: WillPopScope(
        onWillPop: () => willPopAction(),
        child: buidPageView(),
      ),
      drawer: const CustomDrawer(),
      bottomNavigationBar: bottomAppBar,
    );
  }
}
