import 'package:flutter/material.dart';

class DrawerItem {
  final String label;
  final String urlPath;
  final IconData icon;
  final IconData selectedIcon;

  DrawerItem({
    required this.label,
    required this.urlPath,
    required this.icon,
    required this.selectedIcon,
  });
}
