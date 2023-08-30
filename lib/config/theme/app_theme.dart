import 'package:flutter/material.dart';

import 'color_manager.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: ColorManager.colorSeed,

        /// drawer
        drawerTheme: const DrawerThemeData(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          endShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
        ),
        navigationDrawerTheme: const NavigationDrawerThemeData(
          tileHeight: 80,
          elevation: 1,
          indicatorSize: Size.fromHeight(double.infinity),
          indicatorColor: ColorManager.colorSeed,
          iconTheme: MaterialStatePropertyAll(
            IconThemeData(
              color: Colors.white,
              size: 60,
            ),
          ),
          labelTextStyle: MaterialStatePropertyAll(
            TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          indicatorShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              topLeft: Radius.circular(16),
            ),
          ),
          
        ),

        /// Text
        textTheme: const TextTheme(
          labelLarge: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        )
      );
}
