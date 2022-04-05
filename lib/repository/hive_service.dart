


import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/model/characters.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ServiceInitHive with ChangeNotifier{

  Box<Character>? _box;

  Character? character;

  Future<void> init() async{
    Hive.registerAdapter(CharacterAdapter());
    _box = await Hive.openBox('character');
    await Hive.initFlutter();
  }


  void addToFavs(int id, index) async{
      _box?.add(character!);
      notifyListeners();

  }

  void removeFavs(final int id, int index) async{
    final removeFavs = _box?.values.firstWhere((element) => element.results?[index].id == id);
    _box!.delete(removeFavs);
    notifyListeners();
  }
}