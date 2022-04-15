

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/pages/my_home_page.dart';

class Routes extends StatefulWidget {
  static const String id = 'Routes';
  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      initialRoute: MyHomePage.id,
      routes: {
        MyHomePage.id : (context) => MyHomePage(),
      },
    );
  }
}