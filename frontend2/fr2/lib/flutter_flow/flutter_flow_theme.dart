import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FlutterFlowTheme {
  static FlutterFlowTheme of(BuildContext context) => FlutterFlowTheme();

  Color get primaryBackground => Colors.white;
  Color get secondaryBackground => Colors.grey.shade100;
  Color get primaryText => Colors.black;

  Color get primary => const Color(0xFF6750A4); // example
  Color get tertiary => const Color(0xFF03DAC6); // example
  Color get secondary => const Color(0xFF625B71);

  Color get info => const Color(0xFF2196F3); // blue, typical info color

  TextStyle get headlineMedium =>
      GoogleFonts.interTight(fontSize: 22, fontWeight: FontWeight.w600);

  TextStyle get displaySmall =>
      GoogleFonts.interTight(fontSize: 36, fontWeight: FontWeight.w600);

  TextStyle get labelLarge =>
      GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500);

  TextStyle get labelMedium =>
      GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500);

  Color get alternate => const Color(0xFFE0E0E0); // light gray as example

  TextStyle get bodyMedium => GoogleFonts.inter(fontSize: 14);

  Color get error => const Color(0xFFB00020); // typical error red

  Color get secondaryText => const Color(0xFF757575); // gray text color

  TextStyle get titleSmall =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w600);

  TextStyle get titleMedium =>
      GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w600);

  TextStyle get bodyLarge =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400);
}

extension TextStyleHelper on TextStyle {
  TextStyle override({
    String? font,
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
    FontStyle? fontStyle,
    double? letterSpacing,
  }) {
    TextStyle newStyle = copyWith(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
    );

    if (font != null) {
      newStyle = GoogleFonts.getFont(font, textStyle: newStyle);
    }

    return newStyle;
  }
}
