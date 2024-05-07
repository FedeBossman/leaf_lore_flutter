import 'package:flutter/material.dart';

class LeafLoreColors {
  static const transparent = Color(0x00000000);
  static const jet = Color(0xFF3c3744);
  static const ogTiffanyBlue = Color(0xFF8adcc3);
  static const tiffanyBlue = Color.fromARGB(255, 93, 175, 150);
  static const lightTiffanyBlue = Color.fromARGB(255, 151, 218, 197);
  static const skyBlue = Color(0xFF66D8F6);
  static const errorRed = Color.fromARGB(255, 251, 61, 86);
  static const cherryBlossonPink = Color(0xFFFEB7C1);
  static const lightCherryBlossonPink = Color.fromARGB(255, 248, 221, 221);
  static const lighterCherryBlossonPink = Color.fromARGB(255, 250, 246, 246);
  static const leafGreen = Color.fromARGB(255, 204, 230, 284);

  static const spaceCadet = Color(0xFF2e3452);
  static const leafWhite = Color.fromARGB(255, 251, 250, 250);
  static const lightLeafGray = Color.fromARGB(255, 239, 239, 239);
  static const leafGray = Color.fromARGB(255, 131, 130, 135);
  static const devGray = Color.fromARGB(255, 230, 228, 234);

  static const pinkGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 250, 223, 223),
      Color.fromARGB(255, 223, 166, 174),
      Color.fromARGB(255, 244, 211, 198)
    ],
    stops: [0.05, 0.25, 0.85],
  );
  static const tiffanyBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 148, 239, 224),
      Color.fromARGB(255, 161, 234, 212),
      Color.fromARGB(255, 131, 218, 162),
    ],
    stops: [0.05, 0.25, 0.85],
  );

  static const skyBlueGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 86, 197, 249),
      Color.fromARGB(255, 115, 217, 246),
      Color.fromARGB(255, 115, 233, 248)
    ],
    stops: [0.05, 0.25, 0.85],
  );

  static const devGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 54, 53, 98),
      LeafLoreColors.spaceCadet,
      Color.fromARGB(255, 36, 50, 68),
    ],
    stops: [0.05, 0.25, 0.85],
  );

  static const lightGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color.fromARGB(255, 229, 248, 242),
      Color.fromARGB(255, 229, 248, 242),
      Color.fromARGB(255, 212, 255, 240),
    ],
    stops: [0.15, 0.75, 1],
  );
}
