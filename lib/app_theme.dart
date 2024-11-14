import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _colorScheme = ColorScheme.light(
  primary: Color(0xff65558f),
  onPrimary: Color(0xffffffff),
  primaryContainer: Color(0xffeaddff),
  onPrimaryContainer: Color(0xff21005d),
  primaryFixed: Color(0xffeaddff),
  onPrimaryFixed: Color(0xff21005d),
  primaryFixedDim: Color(0xffd0bcff),
  onPrimaryFixedVariant: Color(0xff4f378b),
  outline: Color(0xff79747e),
  surface: Color(0xfffef7ff),
  onSurface: Color(0xff1d1b20),
  onSurfaceVariant: Color(0xff49454f),
  inverseSurface: Color(0xff322f35),
  onInverseSurface: Color(0xfff5eff7),
  inversePrimary: Color(0xffd0bcff),
  shadow: Color(0xff000000),
  surfaceTint: Color(0xff6750a4),
  outlineVariant: Color(0xffcac4d0),
  scrim: Color(0xff000000),
  surfaceContainer: Color(0xfff3edf7),
  surfaceContainerHighest: Color(0xffe6e0e9),
  surfaceContainerHigh: Color(0xffece6f0),
  surfaceContainerLow: Color(0xfff7f2fa),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceBright: Color(0xfffef7ff),
  surfaceDim: Color(0xffded8e1),
  error: Color(0xffd8000c),
  errorContainer: Color(0xfffdeded),
);

final _textTheme = TextTheme(
  headlineSmall: GoogleFonts.roboto(
    fontSize: 24,
    height: 1.33,
    fontWeight: FontWeight.w400,
  ),
  titleLarge: GoogleFonts.roboto(
    fontSize: 22,
    height: 1.27,
    fontWeight: FontWeight.w400,
  ),
  titleMedium: GoogleFonts.roboto(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  titleSmall: GoogleFonts.roboto(
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  labelLarge: GoogleFonts.roboto(
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  labelMedium: GoogleFonts.roboto(
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
  labelSmall: GoogleFonts.roboto(
    fontSize: 11,
    height: 1.45,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  ),
  bodyLarge: GoogleFonts.roboto(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyMedium: GoogleFonts.roboto(
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  bodySmall: GoogleFonts.roboto(
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
);

final appTheme = ThemeData(
  colorScheme: _colorScheme,
  textTheme: _textTheme,
);
