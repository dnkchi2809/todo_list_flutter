import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';

import '../classes/task.dart';
import '../states/select_list_export.dart';
import '../utils/status_by_locale.dart';
import '../utils/status_extension.dart';
import '../widgets/modals/task/delete_task_modal.dart';
import '../widgets/modals/task/edit_task_modal.dart';

class TaskModel extends StatefulWidget {
  final Task task;

  final RecoilNotifier listSelected = useRecoilState(selectListExportState);

  TaskModel({super.key, required this.task});

  @override
  _TaskModelState createState() => _TaskModelState();
}

class _TaskModelState extends State<TaskModel>
    with SingleTickerProviderStateMixin {
  double _opacity = 0;
  double _scale = 0.8;
  bool _isChecked = false; // State for the checkbox
  late RecoilNotifier selectListExport;

  @override
  void initState() {
    super.initState();
    selectListExport = widget.listSelected;

    // Trigger the animation on first display
    Timer(const Duration(milliseconds: 100), () {
      setState(() {
        _opacity = 1;
        _scale = 1;
      });
    });
  }

  void onClickEdit(context) {
    showDialog<void>(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return EditTaskModal(taskRequest: widget.task);
      },
    );
  }

  void onClickDelete(context) {
    showDialog<void>(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return DeleteTaskModal(taskRequest: widget.task);
      },
    );
  }

  void _handleCheckboxChange(bool? value) {
    setState(() {
      _isChecked = value ?? false;
    });

    List currentList = selectListExport.data;

    if (_isChecked) {
      currentList.add(widget.task);
    } else {
      currentList = currentList
          .map((task) => task.toJson())
          .map((taskJson) => Task.fromJson(taskJson))
          .where((task) => task.taskId != widget.task.taskId)
          .toList();
    }
    selectListExport.setData(currentList);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClickEdit(context),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: _opacity,
        child: AnimatedScale(
          duration: const Duration(milliseconds: 300),
          scale: _scale,
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  height: 15,
                  decoration: BoxDecoration(
                    color: colorFromStatus(widget.task.status),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0)),
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      Flexible(
                        flex: 7,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.task.name,
                                          style: TextStyle(
                                              color: Colors.blue.shade900,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Checkbox(
                                          value: _isChecked,
                                          onChanged: _handleCheckboxChange,
                                          activeColor: Colors.blue),
                                    ],
                                  ),
                                  Text(
                                    widget.task.description,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color:
                                          colorFromStatus(widget.task.status),
                                      shape: BoxShape.rectangle,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(5),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(5),
                                    child: Text(statusByLocale(context,
                                        getValueOfStatus(widget.task.status))),
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
                                    child: Text(widget.task.deadline),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Flexible(
                        flex: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => onClickEdit(context),
                              icon: const Icon(Icons.edit_outlined),
                              color: Colors.blue,
                            ),
                            IconButton(
                                onPressed: () => onClickDelete(context),
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
          ),
        ),
      ),
    );
  }
}
