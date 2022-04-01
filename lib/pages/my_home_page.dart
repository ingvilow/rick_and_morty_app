// @dart=2.9

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/model/characters.dart';
import 'package:rick_and_morty_app/providers/search_delegate.dart';

import 'detailed_page.dart';

class MyHomePage extends StatefulWidget {
  final String query;
  const MyHomePage({Key key, this.query}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    Character character = Provider.of<Character>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: FoundHero(widget.query),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2),
        itemCount: character.results.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: [
              Card(
                child: Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(character.results[index].image))),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push<void>(_createRoute());
                    },
                    child: Chip(
                      label: Text(character.results[index].name, style: TextStyle(fontWeight: FontWeight.bold),),
                      backgroundColor: Colors.lime,
                    ),
                  ),
                ),
                margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
              ),
            ],
          );
        },
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) => DetrailedPage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween =
      Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero);
      var curveTween = CurveTween(curve: Curves.ease);

      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    },
  );
}
