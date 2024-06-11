import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_flutter/const.dart';
import '../../classes/task.dart';
import '../buttons/date_picker.dart';
import '../buttons/select_folder.dart';
import '../modal_title.dart';

class AddNewTaskModal extends StatefulWidget {
  const AddNewTaskModal({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddNewTaskModalState();
  }
}

class _AddNewTaskModalState extends State<AddNewTaskModal>{
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
  TextEditingController();

  String? _errorText;

  int? selectedFolderId;

  Future<void> addNewTask() async {
    int newTaskId;
    final String name = taskNameController.text;
    final String description = taskDescriptionController.text;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // await prefs.remove('folders');
    List<String>? taskList = prefs.getStringList('tasks');
    taskList = taskList ?? [];

    // print(folderList);

    var isValidTask = validateTask(name);

    if (!isValidTask) return;

    var lastTask =
    Task.fromJson(jsonDecode(taskList[taskList.length - 1]));
    var lastTaskIdInList = lastTask.taskId;
    newTaskId = lastTaskIdInList + 1;

    // final newTask = Task(newTaskId, name, description, deadline, createDate, Status.Todo, selectedFolderId!);
    // print(newTask);
    //
    // taskList.add(jsonEncode(newTask.toJson()));
    //
    // await prefs.setStringList('tasks', taskList.cast<String>());

    // print('Folder added: $newFolderId, $name, $description, $quantity');
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const ModalTitle('Add a task'),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 600,
                  child: TextField(
                    decoration: InputDecoration(
                      label: const Text('Task title'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: const OutlineInputBorder(),
                      hintText: 'Enter task title',
                      errorText: _errorText
                    ),
                    onChanged: (value) {
                      print(value);
                    },
                  ),
                ),
                const SizedBox(height: 30),
                const SizedBox(
                  width: 600,
                  child: TextField(
                    decoration: InputDecoration(
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
                const SizedBox(width: 600, child: DatePickerDemo()),
                const SizedBox(height: 30),
                SizedBox(
                    width: 600,
                    child: Row(
                      children: [
                        const Text('Select folder'),
                        const SizedBox(width: 10),
                        SelectFolder(taskId: 0, onSelectFolder: _handleSelectFolder),
                      ],
                    )),
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
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Add'),
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

  // Callback function to handle selected folderId
  void _handleSelectFolder(int folderId) {
    setState(() {
      selectedFolderId = folderId; // Update selectedFolderId state variable
    });
    print(selectedFolderId);
  }
}
