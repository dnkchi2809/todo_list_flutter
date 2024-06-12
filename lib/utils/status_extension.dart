import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todo_list_flutter/const.dart';

String enumToStatusValue (Status statusEnum){
  switch (statusEnum) {
    case Status.Todo:
      return 'Todo';
    case Status.InProgress:
      return 'InProgress';
    case Status.Pending:
      return 'Pending';
    case Status.Done:
      return 'Done';
    default:
      return 'All';
  }
}

int enumToStatusIndex (Status statusEnum){
  switch (statusEnum) {
    case Status.Todo:
      return 1;
    case Status.InProgress:
      return 2;
    case Status.Pending:
      return 3;
    case Status.Done:
      return 4;
    default:
      return 0;
  }
}


int getIndexOfStatus(String status) {
  return StatusList.indexOf(status);
}

String getValueOfStatus(int status) {
  return StatusList[status];
}

Color colorFromStatus(int status) {
  switch (status) {
    case 1:
      return Colors.grey.shade300;
    case 2:
      return Colors.yellow.shade200;
    case 3:
      return Colors.orange.shade200;
    case 4:
      return Colors.green.shade200;
    default:
      return Colors.black;
  }
}
