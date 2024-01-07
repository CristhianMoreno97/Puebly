import 'package:flutter/material.dart';

class TownSectionsInfo {
  static List<SectionInfo> get sections => const [
        SectionInfo(
          name: 'Comercio',
          selectedIcon: Icons.storefront_rounded,
          unselectedIcon: Icons.storefront_outlined,
          categoryId: 3,
        ),
        SectionInfo(
          name: 'Turismo',
          selectedIcon: Icons.place_rounded,
          unselectedIcon: Icons.place_outlined,
          categoryId: 4,
        ),
        SectionInfo(
          name: 'Plaza',
          selectedIcon: Icons.shopping_basket_rounded,
          unselectedIcon: Icons.shopping_basket_outlined,
          categoryId: 7,
        ),
        SectionInfo(
          name: 'Empleo',
          selectedIcon: Icons.work_outlined,
          unselectedIcon: Icons.work_outline_outlined,
          categoryId: 5,
        ),
        SectionInfo(
          name: 'Anuncios',
          selectedIcon: Icons.sell_rounded,
          unselectedIcon: Icons.sell_outlined,
          categoryId: 35,
        ),
        SectionInfo(
          name: 'Comunidad',
          selectedIcon: Icons.group_rounded,
          unselectedIcon: Icons.group_outlined,
          categoryId: 36,
        ),
        SectionInfo(
          name: 'Sabías que',
          selectedIcon: Icons.menu_book_rounded,
          unselectedIcon: Icons.menu_book_rounded,
          categoryId: 37,
        ),
      ];
}

class SectionInfo {
  final String name;
  final IconData selectedIcon;
  final IconData unselectedIcon;
  final int categoryId;

  const SectionInfo({
    required this.name,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.categoryId,
  });
}
