import 'package:todo_list_flutter/const.dart';

class Task {
  final int taskId;
  final String name;
  final String description;
  final String deadline;
  final String createDate;
  final Status status;
  final int folderId;

  Task(this.taskId, this.name, this.description, this.deadline, this.createDate,
      this.folderId, this.status);

  Map<String, dynamic> toJson() => {
        'taskId': taskId,
        'name': name,
        'description': description,
        'deadline': deadline,
        'createDate': createDate,
        'status': status,
        'folderId': folderId
      };

  static Task fromJson(Map<String, dynamic> json) => Task(
      json['taskId'],
      json['name'],
      json['description'],
      json['deadline'],
      json['createDate'],
      json['status'],
      json['folderId']);
}
