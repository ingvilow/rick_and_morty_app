import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty_app/providers/task_provider.dart';

class FABWidget extends StatelessWidget {
  const FABWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: const Color(0xffffd900),
      splashColor: Colors.pinkAccent,
      foregroundColor: Colors.white,
      tooltip: 'Add a new task',
      onPressed: () async {
        await showDialog(
          context: context,
          barrierDismissible: true,
          builder: (ctx) {
            return CreateNewPost(ctx: ctx, index: 0);
          },
        );
      },
      child: const Icon(
        Icons.add_task,
        size: 34,
        color: Color(0xff0c89dd),
      ),
    );
  }
}
class CreateNewPost extends StatefulWidget {
  final BuildContext? ctx;
  final int? index;
  CreateNewPost({Key? key, this.ctx, this.index}) : super(key: key);

  @override
  State<CreateNewPost> createState() => _CreateNewPostState();
}

class _CreateNewPostState extends State<CreateNewPost> {
  final _inputController = TextEditingController();

  final TextEditingController? nameController = TextEditingController();
  final TextEditingController? descriptionController = TextEditingController();
   String? name;
   String?  decriptions;

    @override
    Widget build(BuildContext context) {
      var tskProvider =
      Provider.of<TaskProvider>(context, listen: false);

      return SimpleDialog(
        backgroundColor: Theme.of(context).canvasColor,
        contentPadding: const EdgeInsets.all(10),
        titlePadding: const EdgeInsets.all(10),
        title: Text(
          'Add Task',
          textAlign: TextAlign.center,
        ),
        children: [
          TextFormField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Add a new task',
              fillColor: Colors.yellowAccent[100],
              filled: true,
            ),
            style: const TextStyle(
              fontFamily: 'Handlee',
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
            onChanged: (value) {
              String trimmedValue = value.trim();
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: () async {
                  final pickedTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                }, child: Text('choose smth'),
              ),
              TextButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: tskProvider.objectOfSelectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2099),
                  );

                }, child: Text('Add'),
              ),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    tskProvider.addNewTask(
                        name: name!,
                        descriptions: decriptions!
                    );
                    nameController?.clear();
                    tskProvider.getAllTask();
                    Navigator.pop(context);
                  }




                  );
                },
                child: const Icon(Icons.save),
              ),
            ],
          ),
        ],
      );
    }
  }

