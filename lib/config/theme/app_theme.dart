import 'package:flutter/material.dart';

import 'color_manager.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: ColorManager.colorSeed,
      );
}
