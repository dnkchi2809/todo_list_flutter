import 'package:flutter/material.dart';
import '../../../classes/task.dart';
import '../../../utils/get_today.dart';
import '../../../utils/update_folder_list.dart';
import '../../../utils/update_task_list.dart';
import '../../buttons/date_picker.dart';
import '../../buttons/select_folder.dart';
import '../../buttons/select_status.dart';
import '../../modal_title.dart';

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

    var isValidTask = validateTask(name);

    if (!isValidTask) return;

    final updateTask = Task(currentTask.taskId, name, description, deadline!,
        updateDate, selectedStatus!, selectedFolderId!);

    updateTaskList(updateTask);

    updateTaskIdInFolderList(currentTask.folderId, selectedFolderId, currentTask.taskId);

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
                          SelectFolder(
                            onSelectFolder: _handleSelectFolder,
                            folderId: selectedFolderId!,
                          ),
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