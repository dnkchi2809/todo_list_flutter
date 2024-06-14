import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';

import '../states/menu_state.dart';
import '../states/select_list_export.dart';
import '../states/status_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DrawerWidget extends RecoilWidget {
  DrawerWidget({super.key});

  final menuSelected = useRecoilState(menuState);
  final statusSelected = useRecoilState(statusState);
  final selectListExport = useRecoilState(selectListExportState);

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
              title: Text(AppLocalizations.of(context)!.home),
              onTap: () {
                Navigator.pop(context);
                menuSelected.setData('Home');
                statusSelected.setData(0);
                selectListExport.setData([]);
              },
            ),
            ListTile(
              title: Text(AppLocalizations.of(context)!.folders),
              onTap: () {
                Navigator.pop(context);
                menuSelected.setData('Folders');
                statusSelected.setData(0);
                selectListExport.setData([]);
              },
            ),
          ],
        ));
  }
}