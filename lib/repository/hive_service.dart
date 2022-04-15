import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/model/characters.dart';
import 'package:hive_flutter/hive_flutter.dart';


/*
class ServiceInitHive with ChangeNotifier{

  Box<List<CharacterAll>>? _box;

  Box?  _mode;

  List<CharacterAll>? character;

  Future<void> init() async{
    Hive.registerAdapter(CharacterAllAdapter());
    _box = await Hive.openBox('character');
   _mode = await Hive.openBox('darkMode');
    await Hive.initFlutter();
    notifyListeners();
  }

  void swithThemePut(bool? darkmode){
   _mode?.put('darkMode', darkmode!);
   notifyListeners();
  }
  
  void switchThemeGet(){
     _mode?.get('darkMode', defaultValue: false);
    notifyListeners();
    
  }

  void addToFavs(int id, index) async{
      _box?.add(character!);
      notifyListeners();

  }

  void removeFavs(final int id, int index) async{
    final removeFavs = _box?.values.firstWhere((element) => element[index].id == id);
    _box!.delete(removeFavs);
    notifyListeners();
  }
}
*/
