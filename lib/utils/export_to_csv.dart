import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:todo_list_flutter/widgets/modals/message/show_message.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> exportToCsv(BuildContext context, List tasks) async {
  List<List<dynamic>> rows = [];

  // Header row
  rows.add([
    'Task ID',
    'Name',
    'Description',
    'Deadline',
    'Create Date',
    'Status',
    'Folder ID',
    'Update Times'
  ]);

  // Data rows
  tasks.forEach((task) {
    print(task);
    rows.add([
      task.taskId,
      task.name,
      task.description,
      task.deadline,
      task.createDate,
      task.status,
      task.folderId,
      task.updateTimes.join(', '), // Join update times into a single string
    ]);
  });

  String csvData = const ListToCsvConverter().convert(rows);

  String? outputFile = await FilePicker.platform.saveFile(
    dialogTitle: AppLocalizations.of(context)!.selectSavePlace,
    fileName: 'export.csv',
  );

  if (rows.length == 1 || outputFile == null) {
    showMessage(context, AppLocalizations.of(context)!.theFileIsNotSaved,
        Colors.grey.shade700);
  } else {
    File file = File(outputFile);
    await file.writeAsString(csvData);

    showMessage(
        context,
        "${AppLocalizations.of(context)!.csvFileSaveTo} $outputFile",
        Colors.blue);
  }
}
