import 'dart:convert';

import '../classes/folder.dart';
import '../classes/task.dart';

int getNewTaskId(prefs) {
  List<String>? taskList = prefs.getStringList('tasks');
  taskList = taskList ?? [];

  if (taskList.isEmpty) {
    return 0;
  } else {
    var lastTask = Task.fromJson(jsonDecode(taskList[taskList.length - 1]));
    var lastTaskIdInList = lastTask.taskId;
    return lastTaskIdInList + 1;
  }
}

int getNewFolderId(folderList){
  var lastFolder =
  Folder.fromJson(jsonDecode(folderList[folderList.length - 1]));
  var lastFolderIdInList = lastFolder.folderId;
  return lastFolderIdInList + 1;
}