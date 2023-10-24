import 'package:flutter/material.dart';
import 'package:weather_forecast_app/theme_manager/font_manager.dart';

ThemeData getApplicationThemeData() {
  return ThemeData(
      scaffoldBackgroundColor: Colors.blue[100],

      // appBarTheme:
      //     AppBarTheme(backgroundColor: ColorManager.primary, elevation: 0),
      fontFamily: FontFamilyConstant.fontFamily);
}
