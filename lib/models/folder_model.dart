import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/classes/folder.dart';
import 'package:todo_list_flutter/states/folder_state.dart';
import 'package:todo_list_flutter/states/status_state.dart';

import '../states/menu_state.dart';
import '../widgets/modals/folder/delete_folder_modal.dart';
import '../widgets/modals/folder/edit_folder_modal.dart';

class FolderModel extends StatelessWidget {
  final Folder folder;

  final folderSelected = useRecoilState(folderState);
  final currentMenuState = useRecoilState(menuState);
  final statusSelected = useRecoilState(statusState);

  FolderModel({super.key, required this.folder});

  void onClickEdit(context) {
    showDialog<void>(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return EditFolderModal(folderRequest: folder);
      },
    );
  }

  void onClickDelete(context) {
    showDialog<void>(
      context: context,
      useSafeArea: true,
      builder: (BuildContext context) {
        return DeleteFolderModal(folderRequest: folder);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        folderSelected.setData(folder);
        currentMenuState.setData('Detail');
        statusSelected.setData(0);
      },
      child: Card(
        color: Colors.blue.shade100,
        child: Column(
          children: [
            Flexible(
              flex: 7,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text(
                          folder.name,
                          style: TextStyle(
                              color: Colors.blue.shade900,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          folder.description,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    ListTile(
                        title: Text(
                      'Tasks: ${folder.taskIds.length}',
                      style: const TextStyle(fontSize: 12),
                    ))
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Visibility(
                visible: folder.folderId != 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => onClickEdit(context),
                      icon: const Icon(Icons.edit_outlined),
                      color: Colors.blue,
                    ),
                    IconButton(
                        onPressed: () => onClickDelete(context),
                        icon: const Icon(Icons.delete_outline),
                        color: Colors.red)
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
