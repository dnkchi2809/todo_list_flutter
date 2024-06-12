import 'dart:convert';

void updateFolderList(prefs, prevFolderId, newFolderId, taskIdToUpdate) {
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
