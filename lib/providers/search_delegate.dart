// @dart=2.9

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/model/characters.dart';
import 'package:rick_and_morty_app/model/characters.dart';

class FoundHero extends SearchDelegate {
  final String query;

  FoundHero(this.query);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: FaIcon(FontAwesomeIcons.deleteLeft))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: FaIcon(FontAwesomeIcons.arrowRight));
  }

  @override
  Widget buildResults(BuildContext context) {
    Character character = Provider.of<Character>(context);

    final _results = query != null
        ? character.results
            .where((ex) => ex.name.toLowerCase().contains(query.toLowerCase()))
            .toList()
        : character.results;

    if (query.length < 3) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Text(
              "Search term must be longer than two letters.",
            ),
          )
        ],
      );
    }

    character == null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          )
        : ListView.builder(
            itemCount: _results.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_results[index].name),
              );
            },
          );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Column();
  }
}
