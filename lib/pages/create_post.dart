


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:rick_and_morty_app/model/PostModels.dart';
import 'package:rick_and_morty_app/providers/post_provider_hive.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
        context.watch<AddPostProvider>().getPost();

        return Consumer<AddPostProvider>(
        builder: (context, model, child) {
      return Scaffold(
        appBar: AppBar(),
        backgroundColor: Colors.grey[200],
        body: Padding(
          padding: EdgeInsets.only(top: 6),
          child: Column(
            children: <Widget>[
              Text(
                'Create new hero',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Lato',
                ),
              ),
              Container(
                height: 90,
                child: ListView.builder(
                  itemCount: model.postList.length,
                  itemBuilder: (context, index) {
                    PostModels post = model.postList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 2,
                        horizontal: 4.5,
                      ),
                      height: 13,
                      // width: 50.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 2),
                            width: 16,
                            decoration: BoxDecoration(
                              color: Colors.green[600],
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.home,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: 3,
                              horizontal: 3,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  post.name!,
                                  style: TextStyle(
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.w600,
                                    fontSize: 4.5,
                                  ),
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Text(
                                  post.descriptions!,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 4,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8),
                            child: PopupMenuButton(
                              onSelected: (item) {
                                switch (item) {
                                  case 'update':
                                    nameController.text = post.name!;
                                    descriptionController.text =
                                        post.descriptions!;

                                    inputItemDialog(context, 'update', index);
                                    break;
                                  case 'delete':
                                    model.removePost(index);
                                }
                              },
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(
                                    value: 'update',
                                    child: Text('Update'),
                                  ),
                                  PopupMenuItem(
                                    value: 'delete',
                                    child: Text('Delete'),
                                  ),
                                ];
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            inputItemDialog(context, 'add');
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 8,
          ),
        ),
      );
    },
    );
  }

  inputItemDialog(BuildContext context, String action, [int? index]) {
    var inventoryDb = Provider.of<AddPostProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: EdgeInsets.only(
              left: 15,
              right: 15,
              top: 40,
            ),
            height: 45,
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    Text(
                      action == 'add' ? 'Add Item' : 'Update Item',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
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
                        if (_formKey.currentState!.validate()) {
                          if (action == 'add') {
                            await inventoryDb.addPost(PostModels(
                              name: nameController.text,
                              descriptions: descriptionController.text,
                            ));
                          } else {
                            await inventoryDb.updateItem(
                                index!,
                                PostModels(
                                  name: nameController.text,
                                  descriptions: descriptionController.text,
                                ));
                          }

                          nameController.clear();
                          descriptionController.clear();

                          inventoryDb.getPost();

                          Navigator.pop(context);
                        }
                      },
                      color: Colors.green[600],
                      child: Text(
                        action == 'add' ? 'Add' : 'update',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}