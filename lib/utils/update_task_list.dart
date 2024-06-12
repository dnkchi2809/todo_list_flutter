import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

Future<void> updateTaskList(newTask) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String>? taskList = prefs.getStringList('tasks');
  taskList = taskList ?? [];

  final newTaskJson = jsonEncode(newTask.toJson());

  final existingTaskIndex = taskList.indexWhere((taskJson) {
    final taskMap = jsonDecode(taskJson);
    return taskMap['taskId'] == newTask.taskId;
  });

  existingTaskIndex != -1
      ? taskList[existingTaskIndex] = newTaskJson
      : taskList.add(newTaskJson);

  await prefs.setStringList('tasks', taskList);
}


void removeInTaskList (currentTaskId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String>? taskList = prefs.getStringList('tasks');
  taskList = taskList ?? [];

  for (int i = 0; i < taskList.length; i++) {
    final taskJson = taskList[i];
    final taskMap = jsonDecode(taskJson);
    final taskId = taskMap['taskId'];

    if(taskId == currentTaskId){
      taskList.removeAt(i);
    }
  }

  await prefs.setStringList('tasks', taskList);
}