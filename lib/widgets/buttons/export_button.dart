import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_list_flutter/states/menu_state.dart';

import '../../states/select_list_export.dart';
import '../../utils/export_to_csv.dart';
import '../modals/message/show_message.dart';

class ExportButton extends RecoilWidget {
  final exportList = useRecoilState(selectListExportState);
  final currentMenuState = useRecoilState(menuState);

  ExportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: currentMenuState.data != "Folders",
      child: TextButton(
        onPressed: () {
          if (exportList.data.isEmpty) {
            showMessage(
                context, AppLocalizations.of(context)!.haveNotSelectTask, Colors.orange);
          } else {
            exportToCsv(context, exportList.data);
          }
        },
        child: Text(
          AppLocalizations.of(context)!.export,
          style: const TextStyle(color: Colors.blue, fontSize: 16),
        ),
      ),
    );
  }
}
