import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:rick_and_morty_app/providers/task_provider.dart';
import 'package:rick_and_morty_app/widgets/bottomnav.dart';
import 'package:rick_and_morty_app/widgets/fab_widget.dart';


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
    var provider = Provider.of<TaskProvider>(context, listen: false);
    provider.getAllTask();
    //  provider.deleteOldTasks();

    return Scaffold(
      // extendBody: true,
      resizeToAvoidBottomInset: false,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.18,
            width: double.infinity,
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, 1),
            child: SizedBox(
              height: MediaQuery.of(context).size.height - 120,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [


                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FABWidget(),

      bottomNavigationBar: const BtmnavBar(),
    );
  }
}


class DialogAlertBox extends StatefulWidget {
  const DialogAlertBox({Key? key}) : super(key: key);

  @override
  _DialogAlertBoxState createState() => _DialogAlertBoxState();
}

class _DialogAlertBoxState extends State<DialogAlertBox> {
  String? name;
  String? description;

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
                        descriptions: description!
                      );
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



