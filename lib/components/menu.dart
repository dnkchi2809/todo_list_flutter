import 'package:flutter/cupertino.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/components/screen_title.dart';

import '../pages/folders_screen.dart';
import '../pages/home_screen.dart';

class Menu extends RecoilWidget{
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ScreenTitle('Home', HomeScreen()),
        ScreenTitle('Folders', FoldersScreen()),
        ScreenTitle('Test', null),
      ],
    );
  }
}