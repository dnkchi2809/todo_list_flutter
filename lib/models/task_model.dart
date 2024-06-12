import 'package:flutter/material.dart';

import '../classes/task.dart';
import '../utils/status_extension.dart';
import '../widgets/modals/edit_task_modal.dart';

class TaskModel extends StatelessWidget {
  final Task task;

  const TaskModel({super.key, required this.task});

  void onClickEdit(context) {
    showDialog<void>(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return EditTaskModal(taskRequest: task);
      },
    );
  }

  void onClickDelete() {
    print('onClickDelete');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            height: 15,
            decoration: BoxDecoration(
              color: colorFromStatus(task.status),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
            ),
          ),
          SizedBox(
            height: 180,
            width: double.maxFinite,
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              task.name,
                              style: TextStyle(
                                  color: Colors.blue.shade900,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              task.description,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: colorFromStatus(task.status),
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Text(getValueOfStatus(task.status)),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Colors.black12,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Text(task.deadline),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => onClickEdit(context),
                        icon: const Icon(Icons.edit_outlined),
                        color: Colors.blue,
                      ),
                      IconButton(
                          onPressed: onClickDelete,
                          icon: const Icon(Icons.delete_outline),
                          color: Colors.red)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
