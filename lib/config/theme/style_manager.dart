import 'package:flutter/material.dart';
import 'package:puebly/config/theme/color_manager.dart';

class StyleManager {
  static ButtonStyle whatsappButtonStyle(BuildContext context, {Color bgColor = ColorManager.whastapp}) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(bgColor),
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
