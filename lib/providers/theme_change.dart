import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty_app/providers/theme_change_controllers.dart';


class SwitchThemeApp with ChangeNotifier{
  final String _dbKey = 'theme';
  Box<dynamic>? _db;
  ThemeModel? _themeModel;

  // Constructor
  ThemeController(Box<dynamic> db) {
    _db=db;
    // if no theme set, default: light theme
    _themeModel = _db!.containsKey(_dbKey) ? ThemeModel.fromDB( _db!.get(_dbKey) ) : ThemeModel.makeDefault();
  }

  void setTheme(String selection){
    _themeModel?.setTheme(selection);
    _db?.put(_dbKey, selection);
    notifyListeners();
  }

  // Getters
  String get currentTheme => _themeModel!.currentTheme;

  ThemeData get themeData => _themeModel!.themeData;
}

