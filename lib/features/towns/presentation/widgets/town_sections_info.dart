import 'package:flutter/material.dart';

class TownSectionsInfo {
  static const List<SectionInfo> sections = [
    SectionInfo(
        name: 'Comercio',
        selectedIcon: Icons.storefront_rounded,
        unselectedIcon: Icons.storefront_outlined),
    SectionInfo(
        name: 'Turismo',
        selectedIcon: Icons.place_rounded,
        unselectedIcon: Icons.place_outlined),
    SectionInfo(
        name: 'Plaza',
        selectedIcon: Icons.shopping_basket_rounded,
        unselectedIcon: Icons.shopping_basket_outlined),
    SectionInfo(
        name: 'Empleo',
        selectedIcon: Icons.work_outlined,
        unselectedIcon: Icons.work_outline_outlined),
    SectionInfo(
        name: 'Anuncios',
        selectedIcon: Icons.sell_rounded,
        unselectedIcon: Icons.sell_outlined),
    SectionInfo(
        name: 'Comunidad',
        selectedIcon: Icons.group_rounded,
        unselectedIcon: Icons.group_outlined),
    SectionInfo(
        name: 'Sabías que',
        selectedIcon: Icons.menu_book_rounded,
        unselectedIcon: Icons.menu_book_rounded),
  ];
}

class SectionInfo {
  final String name;
  final IconData selectedIcon;
  final IconData unselectedIcon;

  const SectionInfo({
    required this.name,
    required this.selectedIcon,
    required this.unselectedIcon,
  });
}
