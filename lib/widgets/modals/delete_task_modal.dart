import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../classes/task.dart';
import '../modal_title.dart';

class DeleteTaskModal extends StatefulWidget {
  final Task taskRequest;

  const DeleteTaskModal({super.key, required this.taskRequest});

  @override
  State<StatefulWidget> createState() {
    return _DeleteTaskModalState();
  }
}

class _DeleteTaskModalState extends State<DeleteTaskModal> {
  late Task currentTask;

  @override
  void initState() {
    super.initState();
    currentTask = widget.taskRequest;
  }

  Future<void> deleteTask() async {
    //update SharedPreferences tasks
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? taskList = prefs.getStringList('tasks');
    taskList = taskList ?? [];

    taskList = updateTaskList(taskList, currentTask.taskId);

    await prefs.setStringList('tasks', taskList);

    updateFolder(prefs, currentTask.folderId, currentTask.taskId);

    Navigator.pop(context);
  }

  List<String> updateTaskList (taskList, currentTaskId){
    for (int i = 0; i < taskList.length; i++) {
      final taskJson = taskList[i];
      final taskMap = jsonDecode(taskJson);
      final taskId = taskMap['taskId'];

      if(taskId == currentTaskId){
        taskList.removeAt(i);
      }
    }
    return taskList;
  }

  void updateFolder(prefs, currentFolderId, taskIdToUpdate) {

    List<String>? folderList = prefs.getStringList('folders');

    if (folderList == null) {
      return; // No need to update or folderList is null
    }

    List updateTaskIds(int folderId, List taskIds) {
      if(folderId.toInt() == currentFolderId){
        taskIds.removeWhere((taskId) => taskId == taskIdToUpdate);
      }

      return taskIds;
    }

    for (int i = 0; i < folderList.length; i++) {
      final folderJson = folderList[i];
      final folderMap = jsonDecode(folderJson);
      final folderId = folderMap['folderId'];
      final taskIds = List.from(folderMap['taskIds']);
      var newTaskIds = updateTaskIds(folderId, taskIds);
      folderMap['taskIds'] = newTaskIds;

      //re-updated folderList
      folderList[i] = jsonEncode(folderMap);
    }

    prefs.setStringList('folders', folderList);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ModalTitle('Delete this task: ${widget.taskRequest.name}'),
            const SizedBox(height: 30),
            SizedBox(
              width: 600,
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: deleteTask,
                        child: const Text('Delete'),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancel'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
