import 'dart:convert' as convert;
import 'dart:io';

import 'package:rick_and_morty_app/model/characters.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<CharacterAll>?> fetchHero() async {
    final response = await http.get(Uri.parse(
        'https://rickandmortyapi.com/api/character/[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23]'));
    var jsonResponse = convert.jsonDecode(response.body) as List;
    print(jsonResponse);
    if (response.statusCode == 200) {
      return jsonResponse.map((e) => CharacterAll.fromJson(e)).toList();
    }
    if (response.statusCode == 404) {
      return throw HttpStatus.notFound;
    }
  }
}
