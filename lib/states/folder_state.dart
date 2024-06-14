import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/classes/folder.dart';

final folderState = Atom<Folder>(
  key: 'folder_state',
  defaultValue: Folder(0, 'Default folder', 'This is a default folder', []),
);
