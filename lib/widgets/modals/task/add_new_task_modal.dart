import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_flutter/const.dart';
import 'package:todo_list_flutter/utils/update_task_list.dart';
import '../../../classes/task.dart';
import '../../../utils/get_new_id.dart';
import '../../../utils/get_today.dart';
import '../../../utils/status_extension.dart';
import '../../../utils/update_folder_list.dart';
import '../../buttons/date_picker.dart';
import '../../buttons/select_folder.dart';
import '../modal_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewTaskModal extends StatefulWidget {
  const AddNewTaskModal({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddNewTaskModalState();
  }
}

class _AddNewTaskModalState extends State<AddNewTaskModal> {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
  TextEditingController();

  String? _errorText;

  int? selectedFolderId;
  String? deadline;

  @override
  void initState() {
    super.initState();

    deadline = getToday();
    selectedFolderId = 0;
  }

  Future<void> addNewTask() async {
    int newTaskId;
    final String name = taskNameController.text;
    final String description = taskDescriptionController.text;
    final String createDate = getToday();
    final List updateTimes = [getCurrentTime()];

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var isValidTask = validateTask(name);

    if (!isValidTask) return;

    newTaskId = getNewTaskId(prefs);

    final newTask = Task(newTaskId, name, description, deadline!, createDate,
        enumToStatusIndex(Status.Todo), selectedFolderId!, updateTimes);

    updateTaskList(newTask);

    updateTaskIdInFolderList(0, selectedFolderId, newTaskId);

    Navigator.pop(context);
  }

  bool validateTask(inputName) {
    //check inputName not empty
    if (inputName.toString().isEmpty) {
      setState(() {
        _errorText = AppLocalizations.of(context)!.taskTitleIsEmpty;
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
            ModalTitle(AppLocalizations.of(context)!.addNewTask),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: taskNameController,
                    decoration: InputDecoration(
                        label: Text(AppLocalizations.of(context)!.taskTitle),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        border: const OutlineInputBorder(),
                        hintText: AppLocalizations.of(context)!.enterTaskTitle,
                        errorText: _errorText),
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: taskDescriptionController,
                    decoration: InputDecoration(
                      label: Text(AppLocalizations.of(context)!.description),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context)!.enterTaskDescription,
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
                      children: [
                        Text(AppLocalizations.of(context)!.selectFolder),
                        const SizedBox(width: 10),
                        SelectFolder(
                          onSelectFolder: _handleSelectFolder,
                          folderId: 0,
                        ),
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
                            onPressed: addNewTask,
                            child: Text(AppLocalizations.of(context)!.add),
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
                            child: Text(AppLocalizations.of(context)!.cancel),
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
}