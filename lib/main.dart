import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/pages/my_home_page.dart';
import 'package:rick_and_morty_app/providers/search_delegate.dart';
import 'package:rick_and_morty_app/providers/theme_change.dart';

import 'package:rick_and_morty_app/repository/api_service.dart';
import 'package:rick_and_morty_app/routes/routes.dart';


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
        ChangeNotifierProvider(create: (context) => SwitchThemeApp()),
        FutureProvider <List<CharacterAll>?> (
            create: (context) => apiService.fetchHero(),
            catchError: (context, error) {
              print(error.toString());
            },
            initialData: []),
      ],
      child: MaterialApp(home:  Routes()),
    );
  }
}

