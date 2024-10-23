import 'package:flutter/material.dart';

/// App-wide color palette
class AppColors {
  // Private constructor to prevent instantiation
  AppColors._();

  /// Primary Colors
  static const Color purple = Color(0xFF7662B3);
  static const Color coral = Color(0xFFF9BEB0);
  static const Color success = Color(0xFF43CE6A);
  static const Color error = Color(0xFFED4C5C);
  static const Color warning = Color(0xFFEDDD4C);
  static const Color accent = Color(0xFF9747FF);

  /// Grayscale
  static const Color white = Color(0xFFFFFFFF);
  static const Color lightGray = Color(0xFFF0EFF5);
  static const Color gray = Color(0xFF808080);
  static const Color mediumGray = Color(0xFF707070);
  static const Color darkGray = Color(0xFF363636);
  static const Color darkerGray = Color(0xFF2D2D2D);
  static const Color lightestGray = Color(0xFFE3E3E3);
  static const Color grayAlt = Color(0xFF868686);

  /// Dark Theme Colors
  static const Color darkBlue = Color(0xFF05101C);
  static const Color navyBlue = Color(0xFF131E29);
  static const Color charcoal = Color(0xFF252525);

  /// Transparent Colors
  static const Color whiteTransparent = Color(0x80FFFFFF); // 50% opacity
  static const Color whiteMediumTransparent = Color(0x99FFFFFF); // 60% opacity
  static const Color whiteHighTransparent = Color(0xB2FFFFFF); // 70% opacity
  static const Color darkBlueTransparent = Color(0x9905101C); // 60% opacity
  static const Color blackTransparent = Color(0x99000000); // 60% opacity
  static const Color blackMediumTransparent = Color(0x80000000); // 50% opacity
  static const Color grayTransparent = Color(0x99AEAEAE); // 60% opacity

  /// Gradients
  static const LinearGradient blackFadeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF000000),
      Color(0x00000000),
    ],
    stops: [0.0, 1.0],
  );

  static const LinearGradient darkBlueFadeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xE605101C), // 90% opacity
      Color(0xFF05101C),
    ],
    stops: [0.0, 1.0],
  );

  static const LinearGradient blueOverlayGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0x4D435A73), // 30% opacity
      Color(0x4D182A3E), // 30% opacity
    ],
    stops: [0.0, 1.0],
  );

  static const LinearGradient colorfulGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x1AFFED00), // 10% opacity yellow
      Color(0x1A00A75D), // 10% opacity green
      Color(0x1A009FE3), // 10% opacity blue
    ],
    stops: [0.0, 0.524, 1.0],
  );
}
