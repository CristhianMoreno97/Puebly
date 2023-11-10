import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/providers/page_controller_provider.dart';
import 'package:puebly/features/home/presentation/providers/scaffoldkey_provider.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';
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
      ref.watch(classifiedWebViewProvider(context)),
      ref.watch(communityWebViewProvider(context)),
      ref.watch(curiositiesWebViewProvider(context)),
    ];

    const tabGradientColors = LinearGradient(colors: [
      ColorManager.pueblyPrimary1,
      ColorManager.pueblyPrimary2,
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
      TabInfo(
        'Anuncios',
        Icons.sell_outlined,
        Icons.sell_rounded,
        tabGradientColors,
      ),
      TabInfo(
        'Comunidad',
        Icons.group_outlined,
        Icons.group_rounded,
        tabGradientColors,
      ),
      TabInfo(
        'Sabías que',
        Icons.menu_book_rounded,
        Icons.menu_book_rounded,
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
        backgroundColor: MaterialStateProperty.all<Color>(ColorManager.pueblyPrimary1),
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
      backgroundColor: ColorManager.pueblyPrimary1,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      toolbarHeight: 64,
      title: const AppBarTitle(),
      leadingWidth: 64,
      leading: appBarLeading,
    );

    void goToWebView(int index) {
      //ref.read(indexWebViewProvider.notifier).state = index;
      final pageController = ref.watch(pageControllerProvider);
      pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      final width = MediaQuery.of(context).size.width;
      double offset = index < 3 ? 0 : index * width * 0.1;
      ref.read(scrollControllerProvider.notifier).update((state) {
        state.animateTo(
          offset,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut,
        );
        return state;
      });
    }

    final bottomAppBar = BottomAppBar(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      surfaceTintColor: ColorManager.pueblyPrimary1,
      elevation: 0,
      child: SingleChildScrollView(
        controller: ref.watch(scrollControllerProvider),
        scrollDirection: Axis.horizontal,
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
      ),
    );

    final showSectionsScreen = ref.watch(showSectionsScreenProvider);
    final showHomeScreen = ref.watch(showHomeScreenProvider);

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

      if (!showSectionsScreen) {
        ref.read(showSectionsScreenProvider.notifier).state = true;
        return false;
      }

      if (!showHomeScreen) {
        ref.read(showHomeScreenProvider.notifier).state = true;
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
              color: ColorManager.colorSeed,
            ));
          }
          if (webViews[index].loadingProgress < 100) {
            return const Center(
                child: CircularProgressIndicator(
              strokeWidth: 8,
              color: ColorManager.colorSeed,
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
