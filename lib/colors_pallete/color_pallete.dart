import 'package:flutter/material.dart';

final myFilters = [
ColorFilter.mode(Colors.transparent, BlendMode.dst),

//grey scale
ColorFilter.matrix([
0.2126, 0.7152, 0.0722, 0, 0,
0.2126, 0.7152, 0.0722, 0, 0,
0.2126, 0.7152, 0.0722, 0, 0,
0, 0, 0, 1, 0,
]
)];




class SizeConfig {
  // static keyword included so you can call this method without instantiating an object of it like so :
  // SizeConfig.height(context, 2)

  static BuildContext? appContext;
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    appContext = context;
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
  }

  static double height(double height) {
    double screenHeight = _mediaQueryData!.size.height / 100;
    return height * screenHeight;
  }

  static double width(double width) {
    double screenWidth = _mediaQueryData!.size.width / 100;
    return width * screenWidth;
  }

  static double textSize(double textSize) {
    double screenWidth = _mediaQueryData!.size.width / 100;
    return textSize * screenWidth;
  }
}