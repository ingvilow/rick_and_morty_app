import 'package:flutter/material.dart';
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
      body: ListView(children: [
      ...inventoryDb!.postList!.map(
      (e) => ListTile(
        title: Text(e.name)))]),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await showDialog<String>(
              context: context,
              builder: (context) => Dialog(
                    child: CreateNewPost(),
                  ));

          if (result != null) {
            await inventoryDb.addPost(PostModels(
              name: nameController?.text,
              descriptions: descriptionController?.text,
            ));
          }

          nameController!.clear();
          descriptionController!.clear();
        },
        label: Icon(
          Icons.add,
          color: Colors.indigo,
        ),
      ),
    );
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
        TextField(
          controller: _inputController,
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

/*

class HomeView extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController? nameController = TextEditingController();
  final TextEditingController? descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var inventoryDb = Provider.of<AddPostProvider?>(context, listen: false);

    return Consumer<AddPostProvider?>(
      builder: (context, model, child) {
        return Scaffold(
          backgroundColor: Colors.grey[200],
          body: Padding(
            padding: EdgeInsets.only(top: 16),
            child: Column(
                children:[
                  SizedBox(height: 30,),
              TextFormField(
                controller: nameController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Item name cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Item name',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              TextFormField(
                controller: descriptionController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Item description cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: 'Item description',
                ),
              ),
              SizedBox(
                height: 40,
              ),
              RaisedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate()) {
                      await inventoryDb!.addPost(PostModels(
                        name: nameController?.text,
                        descriptions: descriptionController?.text,
                      ));
                    }

                    nameController!.clear();
                    descriptionController!.clear();

                    inventoryDb!.getPost();

                    Navigator.pop(context);
                  }
        ) ])));

      },
    );
  }
}
*/
