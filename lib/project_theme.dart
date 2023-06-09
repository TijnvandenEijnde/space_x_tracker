import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';

class ProjectTheme {
  static ThemeData? lightTheme = FlexThemeData.light(
    scheme: FlexScheme.shark,
    surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
    blendLevel: 9,
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    useMaterial3: true,
    swapLegacyOnMaterial3: true,
  );
}
