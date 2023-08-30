import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class StyleManager {
  static ButtonStyle whatsappButtonStyle(BuildContext context,
      {Color bgColor = ColorManager.whastapp}) {
    return ButtonStyle(
      elevation: MaterialStateProperty.all<double>(10),
      backgroundColor: MaterialStateProperty.all<Color>(bgColor),
      textStyle: MaterialStateProperty.all<TextStyle>(
        Theme.of(context).textTheme.labelLarge!.copyWith(
              fontSize: 18,
            ),
      ),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}
