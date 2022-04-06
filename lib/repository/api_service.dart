

import 'dart:convert';
import 'dart:convert' as convert;
import 'dart:io';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rick_and_morty_app/model/characterId.dart';
import 'package:rick_and_morty_app/model/characters.dart';
import 'package:http/http.dart' as http;

class ApiService{

  Future<Character?> fetchHero() async{
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character'));
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if(response.statusCode == 200){
      return Character.fromJson(jsonResponse);
    }
    if(response.statusCode == 404){
      return throw HttpStatus.notFound;
    }
  }

  Future<List<CharacterIds>?> fetchHeroId(String? name) async{
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character/1,2,3,4,5'));
    var jsonResponse = convert.jsonDecode(response.body) as List;
    print(jsonResponse);
    if(response.statusCode == 200){
      return jsonResponse.map((e) => CharacterIds.fromJson(e)).toList();
    }
    if(response.statusCode == 404){
      return throw HttpStatus.notFound;
    }
  }
}