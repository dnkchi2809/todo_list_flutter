import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/classes/folder.dart';
import 'package:todo_list_flutter/states/folder_state.dart';

import '../states/menu_state.dart';
import '../widgets/hooks/folder_detail_hook.dart';

class FolderModel extends StatelessWidget {
  final Folder folder;

  final folderSelected = useRecoilState(folderState);
  final currentMenuState = useRecoilState(menuState);

  FolderModel({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        folderSelected.setData(folder.folderId);
        currentMenuState.setData('Detail');
        Navigator.push(context,
            CupertinoPageRoute(builder: (context) => const FolderDetailHook()));
      },
      child: Card(
        color: Colors.blue.shade100,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 2.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ListTile(
              title: Text(
                folder.name,
                style: TextStyle(
                    color: Colors.blue.shade900, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                folder.description,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            ListTile(
                title: Text(
              'Tasks: ${folder.taskIds.length}',
              style: const TextStyle(fontSize: 12),
            ))
          ],
        ),
      ),
    );
  }
}
