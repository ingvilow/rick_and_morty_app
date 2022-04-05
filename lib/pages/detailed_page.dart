import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/model/characterId.dart';
import 'package:rick_and_morty_app/model/characters.dart';
import 'package:rick_and_morty_app/repository/hive_service.dart';

class DetrailedPage extends StatefulWidget {
  int? id;

  DetrailedPage({Key? key, this.id}) : super(key: key);

  @override
  _DetrailedPageState createState() => _DetrailedPageState();
}

class _DetrailedPageState extends State<DetrailedPage> {
  AnimationController? _controller;

  @override
  Widget build(BuildContext context) {
    CharacterId? character = Provider.of<CharacterId?>(context);
    print(character);
    return Scaffold(
        appBar: AppBar(),
        body: ListView.builder(
            itemCount: character?.results?.length ?? 0,
            itemBuilder: (context, index) {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Center(
                      child: Card(
                          child:
                              Image.network(character!.results![index].image!)),
                    )
                  ]);
            }));
  }
}
