
import 'dart:convert';

import 'package:hive/hive.dart';


part 'characters.g.dart';

List<CharacterAll> characterAllFromJson(String str) => List<CharacterAll>.from(json.decode(str).map((x) => CharacterAll.fromJson(x)));

String characterAllToJson(List<CharacterAll> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 1)
class CharacterAll {
  CharacterAll({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  @HiveField(0)
  int? id;
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? status;
  @HiveField(3)
  String? species;
  String? type;
  String? gender;
  Location? origin;
  Location? location;
  String? image;
  List<String>? episode;
  String? url;
  DateTime? created;

  factory CharacterAll.fromJson(Map<String, dynamic> json) => CharacterAll(
    id: json["id"],
    name: json["name"],
    status: json["status"],
    species: json["species"],
    type: json["type"],
    gender: json["gender"],
    origin: Location.fromJson(json["origin"]),
    location: Location.fromJson(json["location"]),
    image: json["image"],
    episode: List<String>.from(json["episode"].map((x) => x)),
    url: json["url"],
    created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "status": status,
    "species": species,
    "type": type,
    "gender": gender,
    "origin": origin!.toJson(),
    "location": location!.toJson(),
    "image": image,
    "episode": List<dynamic>.from(episode!.map((x) => x)),
    "url": url,
    "created": created!.toIso8601String(),
  };
}

class Location {
  Location({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}
