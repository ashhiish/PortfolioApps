import 'package:flutter/cupertino.dart';
import 'package:tmdb_movies_app/utils/fonts_manager.dart';

TextStyle _getTextStyle(double fontSize, String fontFamily, Color color, FontWeight fontWeight) {
  return TextStyle(fontSize: fontSize, fontFamily: fontFamily, color: color, fontWeight: fontWeight);
}

// regular font Style

TextStyle getRegularTextStyle({double fontSize = FontSizeManager.s14, required Color color}) {
  return _getTextStyle(fontSize, FontsConstants.fontFamily, color, FontWeightManager.regular);
}

TextStyle getBoldTextStyle({double fontSize = FontSizeManager.s24, required Color color}) {
  return _getTextStyle(fontSize, FontsConstants.fontFamily, color, FontWeightManager.bold);
}

TextStyle getLightTextStyle({double fontSize = FontSizeManager.s10, required Color color}) {
  return _getTextStyle(fontSize, FontsConstants.fontFamily, color, FontWeightManager.light);
}
