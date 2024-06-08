import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';

import '../managers/menu_state.dart';

class ScreenTitle extends RecoilWidget{
  final String title;
  final Widget screen;

  ScreenTitle(this.title, this.screen, {super.key, });

  final menuSelected = useRecoilState(menuState);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        menuSelected.setData(title);
        if (screen != null) {
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => screen));
        }
      },
      child: Text(title,
        style: TextStyle(
          color: menuSelected.data == title? Colors.blueAccent: Colors.white38,
          fontSize: 24,
        ),)
    );
  }
}