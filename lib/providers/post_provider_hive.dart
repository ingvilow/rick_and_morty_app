import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:rick_and_morty_app/model/PostModels.dart';

class AddPostProvider extends ChangeNotifier {
  Box<PostModels>? _box;

  List<PostModels>? _posts = [];

  List? get postList => _posts;

  Future<void> init() async {
    Hive.registerAdapter(PostModelsAdapter());
    _box = await Hive.openBox('createPost');
  }

  addPost(PostModels post) async {
    _box?.add(post);

    print('added');
    notifyListeners();
  }

  removePost(int index) async {
    _box?.deleteAt(index);
    notifyListeners();
  }

  List<PostModels> getPost(final String name) {
    final post = _box?.values.where((element) => element.name == name);
    return post!.toList();
  }

  updatePost(int index, PostModels post) {

    _box?.putAt(index, post);

    notifyListeners();
  }

}
