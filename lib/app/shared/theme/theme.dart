import 'package:crono_cube/app/shared/theme/color_scheme.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: lightColorScheme.primary,
        onPrimary: lightColorScheme.onPrimary,
        secondary: lightColorScheme.secondary,
        onSecondary: lightColorScheme.onSecondary,
        tertiary: lightColorScheme.tertiary,
        onTertiary: lightColorScheme.onTertiary,
        error: lightColorScheme.error,
        onError: lightColorScheme.onError,
        background: lightColorScheme.background,
        onBackground: lightColorScheme.onBackground,
        surface: lightColorScheme.surface,
        onSurface: lightColorScheme.onSurface),
    appBarTheme: const AppBarTheme(centerTitle: true));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: darkColorScheme.primary,
        onPrimary: darkColorScheme.onPrimary,
        secondary: darkColorScheme.secondary,
        onSecondary: darkColorScheme.onSecondary,
        tertiary: darkColorScheme.tertiary,
        onTertiary: darkColorScheme.onTertiary,
        error: darkColorScheme.error,
        onError: darkColorScheme.onError,
        background: darkColorScheme.background,
        onBackground: darkColorScheme.onBackground,
        surface: darkColorScheme.surface,
        onSurface: darkColorScheme.onSurface),
    appBarTheme: const AppBarTheme(centerTitle: true));
