import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class StyleManager {
  static ButtonStyle whatsappButtonStyle(BuildContext context,
      {Color bgColor = ColorManager.whastapp}) {
    return ButtonStyle(
      elevation: WidgetStateProperty.all<double>(10),
      backgroundColor: WidgetStateProperty.all<Color>(bgColor),
      textStyle: WidgetStateProperty.all<TextStyle>(
        Theme.of(context).textTheme.labelLarge!.copyWith(
              fontSize: 18,
            ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.symmetric(vertical: 8),
      ),
    );
  }
}
