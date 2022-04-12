

import 'dart:convert';

import 'package:hive/hive.dart';


part 'PostModels.g.dart';

List<PostModels> scheduleVariantsFromJson(String str) => List<PostModels>.from(json.decode(str).map((x) => PostModels.fromJson(x)));

String scheduleVariantsToJson(List<PostModels> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


@HiveType(typeId: 1)
class PostModels{
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? descriptions;

  PostModels({this.name, this.descriptions, });


  factory PostModels.fromJson(Map<String, dynamic> json) => PostModels(
    name: json["name"],
    descriptions: json["descriptions"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "descriptions": descriptions,
  };
}

