import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puebly/config/theme/color_manager.dart';
import 'package:puebly/features/home/presentation/providers/page_controller_provider.dart';
import 'package:puebly/features/home/presentation/providers/utils_provider.dart';

import 'custom_tab_item.dart';

class CustomButtonAppbar extends ConsumerWidget {
const CustomButtonAppbar({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref){
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

    void goToSection(int sectionIndex) {
      ref.read(showHomeScreenProvider.notifier).state = false;
      ref.read(pageControllerProvider.notifier).update((state) {
        state.animateToPage(sectionIndex,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut);
        return state;
      });
    }

    return BottomAppBar(
      color: Colors.white,
      surfaceTintColor: Colors.green,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int index = 0; index < 4; index++)
            CustomTabItem(
              tabInfo: tabs[index],
              isSelected: false,
              onTap: () =>goToSection(index),
            ),
        ],
      ),
    );
  }
}