import 'package:flutter/material.dart';


class SwitchThemeApp with ChangeNotifier{

  var _themeMode = ThemeMode.light;
  ThemeMode get themeMode => _themeMode;

  void setTheme(themeMode) {
    _themeMode = themeMode;
    notifyListeners();
  }
}

class Styles {
  static ThemeData? themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.lime,
      primaryColor: isDarkTheme ? Colors.black : Colors.lime,
      backgroundColor: isDarkTheme ? Colors.indigo : Color(0xffF1F5FB),
      buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),
      focusColor: isDarkTheme ? Color(0xff0B2512) : Color(0xffA8DAB5),
      bottomAppBarColor: isDarkTheme ? Colors.lime : Colors.black,
      disabledColor: Colors.grey,
      cardColor: isDarkTheme ? Colors.grey[800] : Colors.green,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme
          .of(context)
          .buttonTheme
          .copyWith(
          colorScheme: isDarkTheme ? ColorScheme.dark() : ColorScheme.light()),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
      ),
      textSelectionTheme: TextSelectionThemeData(
          selectionColor: isDarkTheme ? Colors.lime : Colors.indigo),
    );
  }
}