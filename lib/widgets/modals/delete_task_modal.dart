import 'package:flutter/material.dart';
import '../../classes/task.dart';
import '../../utils/update_folder_list.dart';
import '../../utils/update_task_list.dart';
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

  void deleteTask() async {
    removeInTaskList(currentTask.taskId);

    updateFolderList(currentTask.folderId, null, currentTask.taskId);

    Navigator.pop(context);
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
