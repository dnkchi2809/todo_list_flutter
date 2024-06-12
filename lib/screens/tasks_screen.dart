import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_flutter/classes/task.dart';
import 'package:todo_list_flutter/models/task_model.dart';

import '../states/status_state.dart';

class TasksScreen extends StatefulWidget {
  final RecoilNotifier statusSelected = useRecoilState(statusState);

  TasksScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TasksScreenState();
  }
}

class _TasksScreenState extends State<TasksScreen> {
  late SharedPreferences prefs;
  List<Task> tasks = [];
  late RecoilNotifier statusAppbarSelected;

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    _startPolling();
    statusAppbarSelected = widget.statusSelected;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String>? storedTasks = prefs.getStringList('tasks');
      if (storedTasks != null) {
        tasks = storedTasks
            .map((folderJson) => Task.fromJson(jsonDecode(folderJson)))
            .where((task) =>
                statusAppbarSelected.data == 0 ||
                task.status == statusAppbarSelected.data)
            .toList();
      }
    });
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 0), (timer) {
      _loadSharedPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1200,
          child: tasks.isNotEmpty
              ? GridView.builder(
                  itemCount: tasks.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, // 4 columns
                    crossAxisSpacing: 3.0, // Horizontal space between each item
                    mainAxisSpacing: 4.0, // Vertical space between each item
                  ),
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TaskModel(task: task));
                  },
                )
              : const Center(
                  child: Text('There is no task found. Please create new task'),
                ),
        ),
      ),
    );
  }
}
