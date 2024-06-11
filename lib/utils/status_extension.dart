import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_list_flutter/const.dart';

extension StatusExtension on Status {
  String get name {
    switch (this) {
      case Status.All:
        return 'All';
      case Status.Todo:
        return 'Todo';
      case Status.InProgress:
        return 'In progress';
      case Status.Pending:
        return 'Pending';
      case Status.Done:
        return 'Done';
    }
  }

  static Status fromString(String status) {
    switch (status) {
      case 'All':
        return Status.All;
      case 'Todo':
        return Status.Todo;
      case 'In progress':
        return Status.InProgress;
      case 'Pending':
        return Status.Pending;
      case 'Done':
        return Status.Done;
      default:
        throw Exception('Invalid status: $status');
    }
  }

  static String fromInt(int status) {
    return StatusList[status];
  }

  static Color colorFromStatus(Status status) {
    switch (status) {
      case Status.Todo:
        return Colors.grey.shade300;
      case Status.InProgress:
        return Colors.yellow.shade200;
      case Status.Pending:
        return Colors.orange.shade200;
      case Status.Done:
        return Colors.green.shade200;
      default:
        return Colors.black;
    }
  }
}
