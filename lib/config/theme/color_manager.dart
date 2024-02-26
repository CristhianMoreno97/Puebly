import 'package:flutter/material.dart';

class ColorManager {
  static const Color colorSeed = brightYellow;
  static const Color secondary = Color(0xff53d400); // usado en puebly 1.0
  static const Color pueblyPrimary1 = Color(0xff00C417);
  static const Color pueblyPrimary2 = Color(0xff00EF1F);
  static const Color pueblyPrimary2a = Color(0xff738B76);
  static const Color pueblyPrimary2c = Color(0xffB3B3B3);
  static const Color pueblySecundary1 = Color(0xffFF9E00);

  /// inputs
  static const Color inputFill = Color(0xffFFFFFF);
  static const Color inputFocusBorder = Color(0xffFFA51B);
  static const Color inputLabel = Color(0xFF89A688);
  static const Color inputFloatingLabel = Color(0xFF304D2F);

  // others
  static const Color whastapp = Color(0xff25D366);

  // customs
  static const Color malachite = Color(0xff00C417);
  static const Color malachiteTint1 = Color(0xffCCF3D1);
  static const Color magenta = Color(0xffFF0099);
  static const Color magentaTint1 = Color(0xffFFCCEB);
  static const Color magentaTint2 = Color(0xffFFE6F5);
  static const Color magentaTint3 = Color(0xffFF99D6);
  static const Color magentaShade1 = Color(0xffCC007A);
  static const Color magentaShade2 = Color(0xff99005C);
  static const Color brightYellow = Color(0xffFFA51B);
  static const Color brightYellowTint1 = Color(0xffFFEDD1);
  static const Color brightYellowTint2 = Color(0xffFFEDD1);
  static const Color brightYellowShade2 = Color(0xffB37413);
  static const Color orangePeel = Color(0xffFF9E00);
  static const Color orangePeelTint1 = Color(0xffFFB133);
  static const Color blueShade2 = Color(0xff1352B3);
  static const Color blueGunmetal = Color(0xff0E2431);
  static const Color greyCultured = Color(0xffF5F5F5);
  static const Color blueOuterSpace = Color(0xff3F4A51);
  
  // Gradients
  static const LinearGradient magentaGradient = LinearGradient(
    colors: [
      magentaShade1,
      magenta,
    ],
  );

  static const LinearGradient pueblyGradient = LinearGradient(
    colors: [
      pueblyPrimary1,
      pueblyPrimary2,
    ],
  );

  static const LinearGradient orangePeelGradient = LinearGradient(
    colors: [
      orangePeel,
      orangePeelTint1,
    ],
  );
}

class ColorPalette1 {
  static const Color color1 = Color(0xff53d400);
  static const Color color1a = Color(0xff87E14D);
  static const Color color2 = Color(0xffadec00);
  static const Color color2a = Color(0xffC6F24D);
  static const Color color3 = Color(0xffffe008);
  static const Color color3a = Color(0xffFFE952);
  static const Color color4 = Color(0xffff7c17);
  static const Color color4a = Color(0xffFFA35D);
  static const Color color5 = Color(0xffff0c1e);
  static const Color color5a = Color(0xffFF5562);
  static const Color color6 = Color(0xFFff0099);
  static const Color color6a = Color(0xFFFF4DB8);
  static const Color color7 = Color(0xFF00e4ff);
  static const Color color7a = Color(0xFF59D9DB);
}


class ColorPalette4 {
  static const Color color1 = Color(0xff8249b4);
  static const Color color1a = Color(0xff080ff8);
  static const Color color2 = Color(0xff5a7888);
  static const Color color2a = Color(0xffC280ff);
  static const Color color3 = Color(0xff31a75c);
  static const Color color3a = Color(0xfff59a23);
  static const Color color4 = Color(0xff56af3a);
  static const Color color4a = Color(0xff027db4);
  static const Color color5 = Color(0xffa0a21c);
  static const Color color5a = Color(0xff70b603);
  static const Color color6 = Color(0xFFd4880c);
  static const Color color6a = Color(0xFFb67903);
  static const Color color7 = Color(0xFFd85314);
  static const Color color7a = Color(0xFF6866cc);
  static const Color color8 = Color(0xFFdd1d1d);
  static const Color color8a = Color(0xFF6866cc);
}
