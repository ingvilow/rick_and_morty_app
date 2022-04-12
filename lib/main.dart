

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/pages/create_post.dart';
import 'package:rick_and_morty_app/providers/task_provider.dart';
import 'package:rick_and_morty_app/providers/theme_change.dart';
import 'package:rick_and_morty_app/repository/api_service.dart';
import 'package:rick_and_morty_app/repository/hive_service.dart';

import 'model/characterId.dart';
import 'model/characters.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  String? name;
   MyApp({Key? key, this.name }) : super(key: key);
  ApiService apiService = ApiService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ServiceInitHive()),
        ChangeNotifierProvider(create: (context) => SwitchThemeApp()),
        ChangeNotifierProvider(create: (context) => TaskProvider()),
        FutureProvider<Character?>(
            create: (context) => apiService.fetchHero(),
            catchError: (context, error) {},
            initialData: null),
        FutureProvider<List<CharacterIds>?>(
            create: (context) => apiService.fetchHeroId(name),
            initialData: [],
          catchError: (context, error) {
            print(error.toString());
          },),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.lime,
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
        home:   FormViewPost(),
      ),
    );
  }
}

