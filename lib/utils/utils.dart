import 'package:flutter/material.dart';

class Utils {
  static void drawerCloser(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldKey,
  ) {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      Navigator.pop(context);
    }
  }

  static void showSnackBar(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldKey,
    String message, {
    Color backgroundColor = Colors.red,
  }) {
    if (context.mounted) {
      Utils.drawerCloser(context, scaffoldKey);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: backgroundColor,
        ),
      );
    }
  }
}