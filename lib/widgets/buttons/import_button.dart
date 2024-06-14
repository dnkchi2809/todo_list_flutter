import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_flutter/utils/get_today.dart';

import '../../classes/task.dart';
import '../../utils/get_new_id.dart';
import '../../utils/update_folder_list.dart';
import '../../utils/update_task_list.dart';

class ImportButton extends StatelessWidget {
  const ImportButton({super.key});

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      File file = File(result.files.single.path!);
      final input = file.openRead();
      final table = await input
          .transform(utf8.decoder)
          .transform(CsvToListConverter())
          .toList();

      final SharedPreferences prefs = await SharedPreferences.getInstance();

      for (var i = 1; i < table.length; i++) {
        var row = table[i];

        Task newTask = Task(
          getNewTaskId(prefs),
          row[1] as String,
          row[2] as String,
          row[3] as String,
          row[4] as String,
          row[5] as int,
          row[6] as int,
          [getCurrentTime()],
        );

        updateTaskList(newTask);

        updateTaskIdInFolderList(0, newTask.folderId, newTask.taskId);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // visible: currentMenuState.data == "Detail",
      child: TextButton(
        onPressed: () {
          _pickFile();
        },
        child: Text(
          AppLocalizations.of(context)!.import,
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
      ),
    );
  }
}
