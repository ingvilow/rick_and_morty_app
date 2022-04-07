

import 'package:hive/hive.dart';

part 'PostModels.g.dart';
@HiveType(typeId: 1)
class PostModels{
  @HiveField(1)
  String? name;
  @HiveField(2)
  String? descriptions;

  PostModels({this.name, this.descriptions,  });
}