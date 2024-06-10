import 'package:flutter/material.dart';

import '../modal_title.dart';

class AddNewTaskModal extends StatelessWidget {
  const AddNewTaskModal({super.key});

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
                const SizedBox(
                  width: 600,
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text('Task title'),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      hintText: 'Enter task title',
                    ),
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
                      hintText: 'Enter task title',
                    ),
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
