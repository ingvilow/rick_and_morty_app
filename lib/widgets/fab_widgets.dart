

import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:rick_and_morty_app/pages/my_home_page.dart';

class FABNav extends StatelessWidget {
  final GlobalKey<FabCircularMenuState> fabKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return FabCircularMenu(
      key: fabKey,
      alignment: Alignment.bottomRight,
      ringColor: Colors.lime.withAlpha(25),
      ringDiameter: 400.0,
      ringWidth: 120.0,
      fabSize: 64.0,
      fabElevation: 8.0,
      fabOpenColor: Colors.white,
      fabCloseColor: Colors.indigo,
      fabColor: Colors.white,
      fabOpenIcon: Icon(Icons.scatter_plot, color: Colors.white),
      fabCloseIcon: Icon(Icons.close, color: Colors.indigo),
      fabMargin: const EdgeInsets.all(16.0),
      animationDuration: const Duration(milliseconds: 300),
      animationCurve: Curves.easeInBack,
      children: <Widget>[
        RawMaterialButton(
          onPressed: () {
            fabKey.currentState!.close();
            Timer(Duration(milliseconds: 300), () {
              Navigator.popAndPushNamed(context, MyHomePage.id);
            });
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: CircleAvatar(
              radius: 32.0,
              backgroundColor: Colors.white,
              child: Icon(Icons.home, color: Colors.indigo)),
        ),
        RawMaterialButton(
          onPressed: () {
            fabKey.currentState!.close();
            Timer(Duration(milliseconds: 300), () {
            });
          },
          shape: CircleBorder(),
          padding: const EdgeInsets.all(24.0),
          child: CircleAvatar(
              radius: 32.0,
              backgroundColor: Colors.white,
              child: Icon(Icons.settings, color: Colors.indigo)),
        ),
      ],
    );
  }
}