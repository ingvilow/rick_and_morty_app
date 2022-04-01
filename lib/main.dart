// @dart=2.9

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/pages/detailed_page.dart';
import 'package:rick_and_morty_app/pages/my_home_page.dart';
import 'package:rick_and_morty_app/repository/api_service.dart';

import 'model/characters.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({Key key}) : super(key: key);
  ApiService apiService = ApiService();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<Character>(
            create: (context) => apiService.fetchHero(),
            catchError: (context, error) {},
            initialData: null),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.lime,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

