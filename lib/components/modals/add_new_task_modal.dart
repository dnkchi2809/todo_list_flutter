import 'package:flutter/material.dart';

import '../modal_title.dart';

/// Flutter code sample for [showModalBottomSheet].

class AddNewTaskModal extends StatelessWidget {
  const AddNewTaskModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(50),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const ModalTitle('Add a task'),
            const SizedBox(height: 50),
            const TextField(
              decoration: InputDecoration(
                label: Text('Task title'),
                icon: Icon(Icons.title),
                border: OutlineInputBorder(),
                hintText: 'Enter task title',
              ),
            ),

            ElevatedButton(
              child: const Text('Close BottomSheet'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
