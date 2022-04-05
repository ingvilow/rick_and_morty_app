

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/model/characters.dart';


class FoundHero extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const FaIcon(FontAwesomeIcons.xmark))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const FaIcon(FontAwesomeIcons.arrowLeft));
  }

  @override
  Widget buildResults(BuildContext context) {
    return SizedBox(
      child: Center(
        child: Card(
          elevation: 2,
          color: Colors.lime,
          child: Text(query),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    Character character = Provider.of<Character>(context);

    final suggestionList = query.isEmpty
        ? character.results
        : character.results!
            .where((element) => element.name!.startsWith(query))
            .toList();
    if (query.length < 2) {
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

    return character == null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Center(child: CircularProgressIndicator()),
            ],
          )
        : ListView.builder(
            itemCount: suggestionList!.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(suggestionList[index].name!),
              );
            },
          );
  }
}
