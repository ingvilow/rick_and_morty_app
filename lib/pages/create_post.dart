import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:rick_and_morty_app/colors_pallete/color_pallete.dart';
import 'package:rick_and_morty_app/model/PostModels.dart';
import 'package:rick_and_morty_app/providers/post_provider_hive.dart';

class FormViewPost extends StatefulWidget {
  const FormViewPost({Key? key}) : super(key: key);

  @override
  _FormViewPostState createState() => _FormViewPostState();
}

class _FormViewPostState extends State<FormViewPost> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController? nameController = TextEditingController();
  final TextEditingController? descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var inventoryDb = Provider.of<AddPostProvider?>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
      itemCount: inventoryDb?.postList?.length,
    itemBuilder: (context, index) {
      PostModels inv = inventoryDb?.postList![index];
      inventoryDb?.getPost(inv.name!);
      return ListTile(
        title: Text(inv.name!),
      );
    }),floatingActionButton: FloatingActionButton.extended(
      onPressed: () async {
        final result = await showDialog<String>(
            context: context,
            builder: (context) => Dialog(
              child: CreateNewPost(),
            ));

        if (result != null) {
          await inventoryDb!.addPost(PostModels(
            name: nameController?.text,
            descriptions: descriptionController?.text,
          ));
        }

        nameController!.clear();
        descriptionController!.clear();

        inventoryDb?.getPost(inventoryDb.postList.toString());

        Navigator.pop(context);
      },
      label: Icon(
        Icons.add,
        color: Colors.indigo,
      ),
    ),);


  }
}

class CreateNewPost extends StatefulWidget {
  CreateNewPost({Key? key}) : super(key: key);

  @override
  State<CreateNewPost> createState() => _CreateNewPostState();
}

class _CreateNewPostState extends State<CreateNewPost> {
  final _inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Do you want to create the new hero?"),
        Padding(
          padding: const EdgeInsets.only(top:16.0),
          child: TextField(
            controller: _inputController,
          ),
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(_inputController.text);
            },
            child: Text('Create'))
      ],
    );
  }
}

