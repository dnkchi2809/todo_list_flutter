import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';

import '../states/menu_state.dart';

class DrawerWidget extends RecoilWidget {
  DrawerWidget({super.key});

  final menuSelected = useRecoilState(menuState);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(color: Colors.blue),
          child: Center(
              child: Text(
            "Todo List Flutter",
            style: TextStyle(color: Colors.white, fontSize: 24),
          )),
        ),
        ListTile(
          title: const Text("Home"),
          onTap: () {
            Navigator.pop(context);
            menuSelected.setData('Home');
          },
        ),
        ListTile(
          title: const Text("Folders"),
          onTap: () {
            Navigator.pop(context);
            menuSelected.setData('Folders');
          },
        ),
      ],
    ));
  }
}
