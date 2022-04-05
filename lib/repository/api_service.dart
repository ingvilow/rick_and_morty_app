

import 'dart:convert';
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

  Future<CharacterId?> fetchHeroId(int? id) async{
    final response = await http.get(Uri.parse('https://rickandmortyapi.com/api/character/?name=morty'));
    var jsonResponse = json.decode(response.body);
    print(jsonResponse);
    if(response.statusCode == 200){
      return CharacterId.fromJson(jsonResponse);
    }
    if(response.statusCode == 404){
      return throw HttpStatus.notFound;
    }
  }
}