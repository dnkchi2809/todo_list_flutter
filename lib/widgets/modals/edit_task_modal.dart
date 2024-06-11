import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../classes/task.dart';
import '../../utils/get_today.dart';
import '../buttons/date_picker.dart';
import '../buttons/select_folder.dart';
import '../buttons/select_status.dart';
import '../modal_title.dart';

class EditTaskModal extends StatefulWidget {
  final Task taskRequest;

  const EditTaskModal({super.key, required this.taskRequest});

  @override
  State<StatefulWidget> createState() {
    return _EditTaskModalState();
  }
}

class _EditTaskModalState extends State<EditTaskModal> {
  late Task currentTask;
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();

  String? _errorText;

  String? deadline;
  int? selectedFolderId;
  int? selectedStatus;

  @override
  void initState() {
    super.initState();
    currentTask = widget.taskRequest;
    taskNameController.text = currentTask.name;
    taskDescriptionController.text = currentTask.description;
    deadline = currentTask.deadline;
    selectedFolderId = currentTask.folderId;
    selectedStatus = currentTask.status;
  }

  Future<void> editTask() async {
    final String name = taskNameController.text;
    final String description = taskDescriptionController.text;
    final String updateDate = getToday();

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // await prefs.remove('tasks');
    List<String>? taskList = prefs.getStringList('tasks');
    taskList = taskList ?? [];

    var isValidTask = validateTask(name);

    if (!isValidTask) return;

    print(currentTask.folderId);
    print(selectedFolderId);

    final newTask = Task(currentTask.taskId, name, description, deadline!, updateDate,
        selectedStatus!, selectedFolderId!);

    taskList = updateTaskList(taskList, newTask);

    await prefs.setStringList('tasks', taskList);

    updateFolder(prefs, currentTask.folderId, selectedFolderId, currentTask.taskId);

    Navigator.pop(context);
  }

  bool validateTask(inputName) {
    //check inputName not empty
    if (inputName.toString().isEmpty) {
      setState(() {
        _errorText = 'Task title is not empty.';
      });
      return false;
    }

    return true;
  }

  void updateFolder(prefs, prevFolderId, newFolderId, taskIdToUpdate) {
    print('newFolderId $newFolderId');
    List<String>? folderList = prefs.getStringList('folders');

    if (folderList == null) {
      return; // No need to update or folderList is null
    }

    List updateTaskIds(int folderId, List taskIds) {
      if(folderId.toInt() == newFolderId){
        print('add in newFolder');
        taskIds.add(taskIdToUpdate);
      } else {
        print('remove in prevFolder');
        taskIds.removeWhere((taskId) => taskId == taskIdToUpdate);
      }

      return taskIds;
    }

    for (var folderJson in folderList) {
      final folderMap = jsonDecode(folderJson);
      final folderId = folderMap['folderId'];
      print('folderId $folderId');
      final taskIds = List.from(folderMap['taskIds']);
      var newTaskIds = updateTaskIds(folderId, taskIds);
      print('newTaskIds: $newTaskIds');
      folderMap['taskIds'] = newTaskIds;
      print('folderMap[taskIds] : $folderMap[$taskIds] ');
    }
    
    print('lastFolderList: $folderList');

    prefs.setStringList('folders', folderList);
  }


  List<String> updateTaskList (taskList, newTask){
    final newTaskJson = jsonEncode(newTask.toJson());

    final existingTaskIndex = taskList.indexWhere((taskJson) {
      final taskMap = jsonDecode(taskJson);
      return taskMap['taskId'] == newTask.taskId;
    });

    existingTaskIndex != -1
        ? taskList[existingTaskIndex] = newTaskJson
        : taskList.add(newTaskJson);

    return taskList;
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
            const ModalTitle('Edit task'),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: taskNameController,
                    decoration: InputDecoration(
                        label: const Text('Task title'),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const OutlineInputBorder(),
                        hintText: 'Enter task title',
                        errorText: _errorText),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: taskDescriptionController,
                    decoration: const InputDecoration(
                      label: Text('Description'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      hintText: 'Enter task description (optional)',
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 6, // Set this
                    maxLines: 10, // and this
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                    width: 600,
                    child: DatePickerDemo(
                      onSelectDeadline: _handleSelectDeadline,
                    )),
                const SizedBox(height: 30),
                SizedBox(
                  width: 600,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Text('Select folder'),
                          const SizedBox(width: 20),
                          SelectFolder(onSelectFolder: _handleSelectFolder),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Select status'),
                          const SizedBox(width: 20),
                          SelectStatus(
                            onSelectStatus: _handleSelectStatus,
                            status: widget.taskRequest.status,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: editTask,
                            child: const Text('Update'),
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
          ],
        ),
      ),
    );
  }

  void _handleSelectDeadline(String selectedDeadline) {
    setState(() {
      deadline = selectedDeadline;
    });
  }

  // Callback function to handle selected folderId
  void _handleSelectFolder(int folderId) {
    setState(() {
      selectedFolderId = folderId; // Update selectedFolderId state variable
    });
  }

  void _handleSelectStatus(int statusIndex) {
    setState(() {
      selectedStatus = statusIndex;
    });
  }
}
