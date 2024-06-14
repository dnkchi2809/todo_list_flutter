import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';

import '../screens/folder_detail_screen.dart';
import '../screens/folders_screen.dart';
import '../screens/tasks_screen.dart';
import '../states/menu_state.dart';

class BodyContent extends RecoilWidget {
  BodyContent({
    super.key,
  });

  final menuSelected = useRecoilState(menuState);

  @override
  Widget build(BuildContext context) {
    switch (menuSelected.data) {
      case "Folders":
        return const FoldersScreen();
      case "Detail":
        return FolderDetailScreen();
      default:
        return TasksScreen();
    }
  }
}
