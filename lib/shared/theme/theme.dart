import 'package:flutter/material.dart';
import 'package:leaf_lore_flutter/shared/theme/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    fontFamily: 'Nunito',
    splashColor: LeafLoreColors.tiffanyBlue.withOpacity(0.4),
    highlightColor: LeafLoreColors.tiffanyBlue.withOpacity(0.2),
    hoverColor: LeafLoreColors.tiffanyBlue.withOpacity(0.3),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(fontWeight: FontWeight.w300),
      bodySmall: TextStyle(fontWeight: FontWeight.w300),
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: LeafLoreColors.tiffanyBlue,
        primary: LeafLoreColors.tiffanyBlue,
        background: LeafLoreColors.lightLeafGray),
    appBarTheme: const AppBarTheme(
      backgroundColor: LeafLoreColors.leafWhite,
      elevation: 1.0,
      surfaceTintColor: LeafLoreColors.leafWhite,
      shadowColor: LeafLoreColors.tiffanyBlue,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: LeafLoreColors.leafWhite,
      elevation: 2.0,
      shadowColor: LeafLoreColors.tiffanyBlue,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: LeafLoreColors.leafWhite,
      elevation: 2.0,
      selectedItemColor: LeafLoreColors.tiffanyBlue,
      unselectedItemColor: LeafLoreColors.leafGray,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: LeafLoreColors.tiffanyBlue,
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
    ),
    cardTheme: CardTheme(
      elevation: 0.0,
      shadowColor: LeafLoreColors.spaceCadet,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.lerp(
            BorderRadius.circular(100), BorderRadius.circular(150), 0.5)!,
        // borderRadius: BorderRadius.only(
        //     topLeft: Radius.elliptical(40, 90),
        //     topRight: Radius.elliptical(60, 100),
        //     bottomLeft: Radius.elliptical(40, 120),
        //     bottomRight: Radius.elliptical(60, 80)),
        // side: BorderSide(
        //   color: Colors.white,
        //   strokeAlign: BorderSide.strokeAlignCenter,
        //   width: 2.0,
        // ),
      ),
    ),
    dividerTheme: const DividerThemeData(
      color: LeafLoreColors.lightTiffanyBlue,
      thickness: 2,
      space: 15.0,
    ),
    inputDecorationTheme: InputDecorationTheme(
      errorStyle: const TextStyle(
        color: LeafLoreColors.errorRed,
        fontWeight: FontWeight.w400,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: LeafLoreColors.lightTiffanyBlue, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: LeafLoreColors.tiffanyBlue, width: 2),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: LeafLoreColors.lightTiffanyBlue, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: LeafLoreColors.errorRed, width: 1),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(color: LeafLoreColors.errorRed, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: LeafLoreColors.jet.withOpacity(0.2), width: 1),
      ),
      filled: true,
      fillColor: LeafLoreColors.leafWhite,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
    ),
    listTileTheme: ListTileThemeData(
      tileColor: LeafLoreColors.leafWhite,
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: LeafLoreColors.spaceCadet,
      contentTextStyle: TextStyle(color: LeafLoreColors.leafWhite),
    ),
    useMaterial3: true,
  );
}
