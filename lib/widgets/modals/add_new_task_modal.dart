import 'package:flutter/material.dart';

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
                const SizedBox(
                    width: 600,
                    child: Row(
                      children: [
                        Text('Select folder'),
                        SizedBox(width: 10),
                        SelectFolder(taskId: 0),
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
}
