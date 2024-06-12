import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_flutter/classes/folder.dart';

Future<void> updateFolderList(Folder newFolder) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String>? folderList = prefs.getStringList('folders');
  folderList = folderList ?? [];

  final newFolderJson = jsonEncode(newFolder.toJson());

  final existingFolderIndex = folderList.indexWhere((folderJson) {
    final folderMap = jsonDecode(folderJson);
    return folderMap['folderId'] == newFolder.folderId;
  });

  existingFolderIndex != -1
      ? folderList[existingFolderIndex] = newFolderJson
      : folderList.add(newFolderJson);

  await prefs.setStringList('folders', folderList);
}

void updateTaskIdInFolderList(prevFolderId, newFolderId, taskIdToUpdate) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String>? folderList = prefs.getStringList('folders');

  if (folderList == null) {
    return; // No need to update or folderList is null
  }

  List updateTaskIds(int folderId, List taskIds) {
    if (folderId.toInt() == newFolderId) {
      if (!taskIds.contains(taskIdToUpdate)) {
        taskIds.add(taskIdToUpdate);
      }
    } else {
      taskIds.removeWhere((taskId) => taskId == taskIdToUpdate);
    }

    return taskIds;
  }

  for (int i = 0; i < folderList.length; i++) {
    final folderJson = folderList[i];
    final folderMap = jsonDecode(folderJson);
    final folderId = folderMap['folderId'];
    final taskIds = List.from(folderMap['taskIds']);
    var newTaskIds = updateTaskIds(folderId, taskIds);
    folderMap['taskIds'] = newTaskIds;

    //re-updated folderList
    folderList[i] = jsonEncode(folderMap);
  }

  prefs.setStringList('folders', folderList);
}

void removeInFolderList(currentFolderId, context) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String>? folderList = prefs.getStringList('folders');
  folderList = folderList ?? [];

  for (int i = 0; i < folderList.length; i++) {
    final folderJson = folderList[i];
    final folderMap = jsonDecode(folderJson);
    final taskId = folderMap['folderId'];

    if (taskId == currentFolderId) {
      if (folderMap['taskIds'].length > 0) {
        ScaffoldMessenger.of(context)
          ..removeCurrentSnackBar()
          ..showSnackBar(SnackBar(
            content: Text(
                "Cannot delete! This folder still contains ${folderMap['taskIds'].length} tasks"),
            backgroundColor: Colors.red,
            duration: const Duration(milliseconds: 2000),
          ));
      } else {
        folderList.removeAt(i);

        await prefs.setStringList('folders', folderList);
      }
    }

    Navigator.pop(context);
  }
}
