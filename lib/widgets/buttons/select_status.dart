import 'package:flutter/material.dart';
import '../../const.dart';
import '../../utils/status_extension.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectStatus extends StatefulWidget {
  final int status;
  final Function(int) onSelectStatus;

  const SelectStatus(
      {super.key, required this.onSelectStatus, required this.status});

  @override
  State<SelectStatus> createState() => _SelectStatusState();
}

class _SelectStatusState extends State<SelectStatus> {
  String? dropdownValue;
  late int currentStatus;
  late List<String> selectStatusList = List.from(StatusList);

  @override
  void initState() {
    super.initState();
    currentStatus = widget.status;
    selectStatusList.removeAt(0);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: getValueOfStatus(currentStatus),
      onSelected: (String? value) {
        widget.onSelectStatus(getIndexOfStatus(value!));

        setState(() {
          dropdownValue = value;
        });
      },
      dropdownMenuEntries:
          selectStatusList.map<DropdownMenuEntry<String>>((String status) {
            String valueByLocale;
            switch (status){
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
            return DropdownMenuEntry<String>(value: status, label: valueByLocale);
      }).toList(),
    );
  }
}
