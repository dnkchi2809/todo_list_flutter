import 'package:flutter/material.dart';

import '../classes/task.dart';
import '../utils/status_extension.dart';

class TaskModel extends StatelessWidget {
  final Task task;

  const TaskModel({super.key, required this.task});

  void onClickEdit() {
    print('onClickEdit');
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
              color: StatusExtension.colorFromStatus(StatusExtension.fromString(
                  StatusExtension.fromInt(task.status))),
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
            ),
          ),
          SizedBox(
            height: 180,
            child: Column(
              children: [
                Flexible(
                  flex: 4,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: StatusExtension.colorFromStatus(
                                    StatusExtension.fromString(
                                        StatusExtension.fromInt(task.status))),
                                shape: BoxShape.rectangle,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5),
                                ),
                              ),
                              padding: const EdgeInsets.all(5),
                              child: Text(StatusExtension.fromInt(task.status)),
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
                              child: Text(task.createDate),
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
                        onPressed: onClickEdit,
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
