import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final _colorScheme = ColorScheme.light(
  primary: Color(0xff65558f),
  onPrimary: Color(0xffffffff),
  outline: Color(0xff79747e),
  surface: Color(0xfffef7ff),
  onSurface: Color(0xff1d1b20),
  onSurfaceVariant: Color(0xff49454f),
  outlineVariant: Color(0xffcac4d0),
  surfaceContainerHighest: Color(0xffe6e0e9),
  surfaceContainer: Color(0xfff3edf7),
  surfaceContainerLow: Color(0xfff7f2fa),
  surfaceContainerLowest: Color(0xffffffff),
  surfaceDim: Color(0xffded8e1),
  error: Color(0xffff3322),
);

final _textTheme = TextTheme(
  titleMedium: GoogleFonts.roboto(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  bodyLarge: GoogleFonts.roboto(
    fontSize: 16,
    height: 1.5,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodySmall: GoogleFonts.roboto(
    fontSize: 12,
    height: 1.33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  labelLarge: GoogleFonts.roboto(
    fontSize: 14,
    height: 1.43,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
);

final appTheme = ThemeData(
  colorScheme: _colorScheme,
  textTheme: _textTheme,
);
