import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/pages/folders_screen.dart';
import 'package:todo_list_flutter/pages/home_screen.dart';

import '../states/menu_state.dart';

class BodyContent extends RecoilWidget {
  BodyContent({
    super.key,
  });

  final menuSelected = useRecoilState(menuState);

  @override
  Widget build(BuildContext context) {
    return menuSelected.data == 'Folders'
        ? const FoldersScreen()
        : const HomeScreen();
  }
}
