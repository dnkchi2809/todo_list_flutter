import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../const.dart';
import '../../states/status_state.dart';
import '../../utils/status_extension.dart';

class DropdownStatusButton extends RecoilWidget {
  final statusSelected = useRecoilState(statusState);

  DropdownStatusButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          AppLocalizations.of(context)!.status,
          style: const TextStyle(fontSize: 16),
        ),
        DropdownButton<String>(
          value: getValueOfStatus(statusSelected.data),
          icon: const Icon(Icons.arrow_downward),
          elevation: 16,
          style: const TextStyle(color: Colors.deepPurple),
          underline: Container(
            height: 2,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(15),
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          onChanged: (String? value) {
            statusSelected
                .setData(value!.isNotEmpty ? getIndexOfStatus(value) : statusSelected.data);
          },
          items: StatusList.map<DropdownMenuItem<String>>((String value) {
            String valueByLocale;
            switch (value){
              case "To do":
                valueByLocale = AppLocalizations.of(context)!.toDo;
                break;
              case "In progress":
                valueByLocale = AppLocalizations.of(context)!.inProgress;
                break;
              case "Pending":
                valueByLocale = AppLocalizations.of(context)!.pending;
                break;
              case "Done":
                valueByLocale = AppLocalizations.of(context)!.done;
                break;
              default:
                valueByLocale = AppLocalizations.of(context)!.all;
                break;
            }
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                valueByLocale,
                style: TextStyle(
                    color: value == statusSelected.data
                        ? Colors.blue
                        : Colors.black),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}