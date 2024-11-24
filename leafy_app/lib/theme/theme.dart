import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class AppTheme {
  // Tema claro



 
  static ThemeData lightTheme = FlexThemeData.light(
    colors: const FlexSchemeColor(
      primary: Color.fromARGB(255, 4, 84, 70),
      primaryContainer: Color(0xffd0e4ff),
      primaryLightRef: Color(0xff004881),
      secondary: Color(0xffac3306),
      secondaryContainer: Color(0xffffdbcf),
      secondaryLightRef: Color(0xffac3306),
      tertiary: Color(0xff006875),
      tertiaryContainer: Color(0xff95f0ff),
      tertiaryLightRef: Color(0xff006875),
      appBarColor: Color(0xffffdbcf),
      error: Color(0xffba1a1a),
      errorContainer: Color(0xffffdad6),
    ),
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    // Puedes incluir la fuente que prefieras descomentando y configurando:
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );



  // Tema oscuro
  static ThemeData darkTheme = FlexThemeData.dark(
    colors: const FlexSchemeColor(
      primary: Color.fromARGB(255, 4, 84, 70),
      primaryContainer: Color(0xff003330),
      primaryLightRef: Color(0xff004881),
      secondary: Color(0xff00b2b9),
      secondaryContainer: Color(0xff004e59),
      secondaryLightRef: Color(0xffac3306),
      tertiary: Color(0xff2962ff),
      tertiaryContainer: Color(0xff00325b),
      tertiaryLightRef: Color(0xff006875),
      appBarColor: Color(0xffffdbcf),
      error: Color(0xffff0000),
      errorContainer: Color(0xff93000a),
    ),
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
      navigationRailLabelType: NavigationRailLabelType.all,
    ),
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
    // Puedes incluir la fuente que prefieras descomentando y configurando:
    // fontFamily: GoogleFonts.notoSans().fontFamily,
  );

  // static ThemeMode themeMode = ThemeMode.system; En caso de querer usar el tema por defecto del teléfono ;)
}