


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_app/pages/detailed_page.dart';

class BtmnavBar extends StatefulWidget {
  const BtmnavBar({Key? key}) : super(key: key);

  @override
  _BtmnavBarState createState() => _BtmnavBarState();
}

class _BtmnavBarState extends State<BtmnavBar> {

  int? index = 0;

  void changeScreen(int newIndex) {
    if (newIndex == 1) {
      Navigator.of(context).push(
        CupertinoPageRoute(builder: (context) =>  DetrailedPage()),
      );
    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        color: Theme.of(context).primaryColor,
        elevation: 0,
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.indigo,
          unselectedItemColor: Colors.black,
          onTap: (index) => changeScreen(index),
          iconSize: 24,
          unselectedFontSize: 14,
          selectedFontSize: 16,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.task_alt_rounded),
              label: 'All Heroes',
              tooltip: 'View Hero',
            ),
            BottomNavigationBarItem(
              tooltip: 'View All Chosen Hero',
              icon: Icon(Icons.done_all),
              label: 'Chosen Hero',
            ),
          ],
        ),
      ),
    );
  }
}
