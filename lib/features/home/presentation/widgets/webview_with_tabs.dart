import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/providers/webview_providers.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWithTabs extends ConsumerWidget {
  const WebViewWithTabs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final webViews = [
      ref.watch(commerceWebviewControllerProvider),
      ref.watch(employmentWebviewControllerProvider),
      ref.watch(marketWebviewControllerProvider),
      ref.watch(tourismWebviewControllerProvider),
    ];
    final indexWebView = ref.watch(indexWebViewProvider);
    final pageController = ref.watch(pageControllerProvider);
    final tabs = [
      TabInfo(
          'Comercio',
          Icons.storefront_outlined,
          Icons.storefront_rounded,
          const LinearGradient(
              colors: [ColorPalette1.color7, ColorPalette1.color7a])),
      TabInfo(
          'Empleo',
          Icons.work_outline_outlined,
          Icons.work_outlined,
          const LinearGradient(
              colors: [ColorPalette1.color1, ColorPalette1.color2a])),
      TabInfo(
          'Plaza',
          Icons.shopping_basket_outlined,
          Icons.shopping_basket_rounded,
          const LinearGradient(
              colors: [ColorPalette1.color4, ColorPalette1.color4a])),
      TabInfo(
          'Turismo',
          Icons.place_outlined,
          Icons.place_rounded,
          const LinearGradient(
              colors: [ColorPalette1.color5, ColorPalette1.color5a])),
    ];

    return Scaffold(
      body: PageView.builder(
        controller: pageController,
        itemCount: webViews.length,
        itemBuilder: (context, index) =>
            WebViewWidget(controller: webViews[index]),
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) =>
            ref.read(indexWebViewProvider.notifier).state = index,
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        surfaceTintColor: Colors.black,
        elevation: 20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            for (int i = 0; i < webViews.length; i++)
              CustomTabBarItem(
                tabInfo: tabs[i],
                isSelected: indexWebView == i,
                onTap: () {
                  pageController.jumpToPage(i);
                },
              ),
          ],
        ),
      ),
    );
  }
}

class TabInfo {
  final String label;
  final IconData iconData;
  final IconData iconDataSelected;
  final LinearGradient gradient;

  TabInfo(
    this.label,
    this.iconData,
    this.iconDataSelected,
    this.gradient,
  );
}

class CustomTabBarItem extends StatelessWidget {
  final TabInfo tabInfo;
  final bool isSelected;
  final VoidCallback onTap;

  const CustomTabBarItem({
    super.key,
    required this.tabInfo,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final tabColor = isSelected ? tabInfo.gradient : null;
    const textColor = Colors.white;
    final iconColor = isSelected ? Colors.white : tabInfo.gradient.colors[0];
    final boxShadow = isSelected
        ? [
            BoxShadow(
              color: tabInfo.gradient.colors[0].withOpacity(0.6),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ]
        : null;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: tabColor,
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
          boxShadow: boxShadow,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? tabInfo.iconDataSelected : tabInfo.iconData,
              color: iconColor,
              size: 32,
              shadows: isSelected
                  ? [
                      Shadow(
                        color: Colors.black.withOpacity(0.4),
                        blurRadius: 4,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : null,
            ),
            if (isSelected)
              Flexible(
                child: SizedBox(
                  width: 80,
                  child: Center(
                    child: Text(
                      tabInfo.label,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 4,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
