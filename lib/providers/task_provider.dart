import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:rick_and_morty_app/model/PostModels.dart';


class TaskProvider extends ChangeNotifier {
  static const boxName = 'task box';

  List<PostModels>? _taskList = [];
  String stringOfDedTime = '';
  DateTime objectOfDedTime = DateTime.now();

  String stringOfSelectedDate = '';
  DateTime objectOfSelectedDate = DateTime.now();


  void getAllTask() async {
    var box = await Hive.openBox<PostModels?>(boxName);
    _taskList = box.values.cast<PostModels>().toList();
    notifyListeners();
  }


  int currentTotalTaskCount(List<PostModels> tskList) {
    return tskList.length;
  }


  int get getTotalTaskCount {
    return _taskList!.length;
  }



  void addNewTask({required String name,
    required String descriptions,
  }) async {
    var box = await Hive.openBox<PostModels>(boxName);
    await box.add(
      PostModels(
          name: name,
          descriptions: descriptions,
          ),
    );
    _taskList = box.values.toList();


    notifyListeners();
  }

  void editTask({required String name, required PostModels edititedTask}) async {
    var box = await Hive.openBox<PostModels>(boxName);
    _taskList = box.values.toList();
    PostModels? toEditTask = _taskList!.firstWhere((task) => task?.name == name);
    int editItemIndex = _taskList!.indexOf(toEditTask);

    await box.putAt(editItemIndex, edititedTask);
    _taskList = box.values.toList();
    notifyListeners();
  }

  /*
  void toggleTask(
      {required DateTime id,
      required String taskTitle,
      required DateTime completeOnDate,
      required bool newVal}) async {
    var box = await Hive.openBox<Task>(boxName);
    _taskList = box.values.toList();
    Task toModifyTask = _taskList.firstWhere(
      (item) => item.taskId == id && item.taskName == taskTitle,
    );
    toModifyTask.isFinished = newVal;
    toModifyTask.completedOn = completeOnDate;

    int toModifyTaskIndex = _taskList.indexOf(toModifyTask);
    await box.putAt(toModifyTaskIndex, toModifyTask);
    _taskList = box.values.toList();

    notifyListeners();
  }

  void removeSingleTask(
      {required DateTime id, required String taskTitle}) async {
    var box = await Hive.openBox<Task>(boxName);
    _taskList = box.values.toList();
    Task toDeleteTask = _taskList
        .firstWhere((task) => task.taskId == id && task.taskName == taskTitle);
    int toDeleteItemIndex = _taskList.indexOf(toDeleteTask);
    await box.deleteAt(toDeleteItemIndex);

    _sortedTasksByDate = box.values
        .where((task) => task.deadLineDate == stringOfSelectedDate)
        .toList();
    _taskList = box.values.toList();
    notifyListeners();
  }

  void deleteAllCompletedTasks() async {
    var box = await Hive.openBox<Task>(boxName);
    _taskList = box.values.toList();
    List<Task> toDeleteTasks =
        box.values.where((task) => task.isFinished == true).toList();

    for (Task task in toDeleteTasks) {
      if (toDeleteTasks.isNotEmpty) {
        await box.deleteAt(_taskList.indexOf(task));
        _taskList =
            box.values.toList(); //updating list after every deletioin performed
      } else {
        return;
      }
    }
    _sortedTasksByDate = box.values
        .where((task) => task.deadLineDate == stringOfSelectedDate)
        .toList();
    _taskList = box.values.toList();
    notifyListeners();
  }
*/
  // void deleteOldTasks() async {
  //   var box = await Hive.openBox<Task>(boxName);
  //   _taskList = box.values.toList();
  //   List<Task> toDeleteOlderTasks = box.values
  //       .where((task) =>
  //           task.createdDate.day ==
  //           DateTime.now().subtract(const Duration(days: 4)).day)
  //       .toList();
  //   for (Task task in toDeleteOlderTasks) {
  //     if (toDeleteOlderTasks.isNotEmpty) {
  //       await box.deleteAt(_taskList.indexOf(task));
  //       _taskList =
  //           box.values.toList(); //updating list after every deletioin performed
  //     } else {
  //       return;
  //     }
  //   }
  //   _sortedTasksByDate = box.values
  //       .where((task) => task.deadLineDate == stringOfSelectedDate)
  //       .toList();
  //   _taskList = box.values.toList();
  //   notifyListeners();
  // }

}
