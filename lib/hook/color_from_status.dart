import 'package:flutter/material.dart';
import 'package:todo_list_flutter/const.dart';

Color colorFromStatus(Status status) {
  switch (status) {
    case Status.Todo:
      return Colors.grey.shade200;
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