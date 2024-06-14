import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import '../../classes/task.dart';
import '../../models/task_model.dart';

class TaskModelHook extends RecoilWidget{
  final Task task;
  
  const TaskModelHook({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return TaskModel(task: task,);
  }
}