import 'package:flutter/material.dart';

class NavigationDrawerItem {
  final String label;
  final String urlPath;
  final Icon icon;
  final Icon selectedIcon;

  NavigationDrawerItem({
    required this.label,
    required this.urlPath,
    required this.icon,
    required this.selectedIcon,
  });
}
