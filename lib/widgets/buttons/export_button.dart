import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../states/select_list_export.dart';

class ExportButton extends RecoilWidget {
  final exportList = useRecoilState(selectListExportState);

  ExportButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      // visible: currentMenuState.data == "Detail",
      child: TextButton(
        onPressed: () {
          print(exportList.data);
        },
        child: Text(
          AppLocalizations.of(context)!.export,
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
      ),
    );
  }
}
