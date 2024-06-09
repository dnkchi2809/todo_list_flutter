import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../modals/add_new_task_modal.dart';

class AddButton extends StatelessWidget{
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: (){
        showModalBottomSheet<void>(
          context: context,
          useSafeArea: true,
          constraints: const BoxConstraints(
            maxHeight: 700,
            maxWidth: 700,
          ),
          isScrollControlled: true,
          builder: (BuildContext context) {
            return const AddNewTaskModal();
          },
        );
      },
      style: IconButton.styleFrom(
        backgroundColor: Colors.blue.shade200,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)),
      ),
      icon: const Icon(
        Icons.add_task,
        size: 30,
        color: Colors.black54,
      ),
      tooltip: 'Add  new todo',
    );
  }
  
}