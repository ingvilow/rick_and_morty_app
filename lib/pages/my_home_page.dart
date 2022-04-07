import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/model/characters.dart';
import 'package:rick_and_morty_app/providers/search_delegate.dart';
import 'package:rick_and_morty_app/providers/theme_change.dart';
import 'package:rick_and_morty_app/repository/hive_service.dart';

import 'detailed_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Character? character = Provider.of<Character?>(context);
    var characters = Provider.of<ServiceInitHive>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: FoundHero(),
              );
            },
          ),
          Consumer<ServiceInitHive> (
            builder: (context, value, _){
              characters.switchThemeGet();
              return  Switch.adaptive(
                  activeColor: Colors.indigo,
                  value: true,
                  onChanged: (bool value) {
                    characters.swithThemePut(value);
                  });
            },
          )
        ],
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: character?.results?.length ?? 0,
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
                          image:
                              NetworkImage(character!.results![index].image!))),
                  child: GestureDetector(
                    onTap: () {
                      print('errr');
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetrailedPage(
                                  name: character.results![index].name)));
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Chip(
                          label: Text(
                            character.results![index].name!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          deleteIcon: IconButton(
                              onPressed: () {
                                print('some result');
                                characters.addToFavs(
                                    character.results![index].id!, index);
                              },
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )),
                          backgroundColor: Colors.lime,
                        ),
                      ],
                    ),
                  ),
                ),
                margin:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
              ),
            ],
          );
        },
      ),
    );
  }
}
