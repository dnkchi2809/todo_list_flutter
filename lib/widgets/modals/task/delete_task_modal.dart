import 'package:flutter/material.dart';
import '../../../classes/task.dart';
import '../../../utils/update_folder_list.dart';
import '../../../utils/update_task_list.dart';
import '../../modal_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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

    updateTaskIdInFolderList(currentTask.folderId, null, currentTask.taskId);

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
            ModalTitle(AppLocalizations.of(context)!.deleteTask + widget.taskRequest.name),
            const SizedBox(height: 30),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.warning, color: Colors.red,),
                Text(
                  AppLocalizations.of(context)!.cannotUndone,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 400,
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
                        child: Text(AppLocalizations.of(context)!.delete),
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
      ),
    );
  }
}
