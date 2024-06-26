import 'package:flutter/material.dart';

import '../modals/task/add_new_task_modal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewTaskButton extends StatelessWidget {
  const AddNewTaskButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          useSafeArea: true,
          builder: (BuildContext context) {
            return const AddNewTaskModal();
          },
        );
      },
      style: IconButton.styleFrom(
        backgroundColor: Colors.blue.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: const Icon(
        Icons.add,
        size: 30,
        color: Colors.black54,
      ),
      tooltip: AppLocalizations.of(context)!.addNewTask,
    );
  }
}
