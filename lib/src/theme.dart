import 'package:flutter/material.dart';

class AppColors {
  static const Color backgroundColor = celadonBlue;
  static const Color textColor = prussianBlue;
  static const Color titleColor = honeydew;
  static const Color buttonColor = imperialRed;

  static const Color imperialRed = Color(0xFFE63946);
  static const Color honeydew = Color(0xFFF1FAEE);
  static const Color powerBlue = Color(0xFFA8DADC);
  static const Color celadonBlue = Color(0xFF457B9D);
  static const Color prussianBlue = Color(0xFF1D3557);

  static const Color cardTitleColor = Color(0xff5c64fe);
  static const Color cardColor = Color(0xFFFDFDFD);
}

ThemeData appTheme(BuildContext context) => ThemeData(
      primaryColor: AppColors.celadonBlue,
      primaryColorDark: AppColors.prussianBlue,
      textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Open Sans'),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(AppColors.buttonColor),
              padding: MaterialStateProperty.all(const EdgeInsets.all(12)))),
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: AppColors.prussianBlue),
      inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1, color: AppColors.celadonBlue)),
          hintStyle: TextStyle(color: AppColors.celadonBlue),
          labelStyle: TextStyle(color: AppColors.celadonBlue)),
    );

class AppFontStyle {
  Color color = AppColors.textColor;
  FontWeight weight = FontWeight.normal;
  double height = 1.1;
  String family = 'Open Sans';

  final double size;

  AppFontStyle.h1() : size = 32.0;

  AppFontStyle.h2() : size = 22.0;

  AppFontStyle.h3() : size = 20.0;

  AppFontStyle.p1() : size = 18.0;

  AppFontStyle.p2() : size = 14.0;

  AppFontStyle.custom(this.size);

  AppFontStyle withColor(Color color) {
    this.color = color;
    return this;
  }

  AppFontStyle withHeight(double value) {
    height = value;
    return this;
  }

  AppFontStyle withFamily(String value) {
    family = value;
    return this;
  }

  AppFontStyle get light {
    weight = FontWeight.w300;
    return this;
  }

  AppFontStyle get normal {
    weight = FontWeight.normal;
    return this;
  }

  AppFontStyle get medium {
    weight = FontWeight.w500;
    return this;
  }

  AppFontStyle get bold {
    weight = FontWeight.bold;
    return this;
  }

  AppFontStyle get semiBold {
    weight = FontWeight.w600;
    return this;
  }

  build() => TextStyle(fontSize: size, color: color, fontWeight: weight, height: height, fontFamily: family);
}
