import 'package:flutter/cupertino.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/components/screen_title.dart';

class Menu extends RecoilWidget{
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ScreenTitle('Home'),
        ScreenTitle('Folders'),
        ScreenTitle('Test'),
      ],
    );
  }
}