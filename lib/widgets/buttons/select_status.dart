import 'package:flutter/material.dart';
import '../../const.dart';
import '../../utils/status_extension.dart';

class SelectStatus extends StatefulWidget {
  final int status;
  final Function(int) onSelectStatus;

  const SelectStatus({super.key, required this.onSelectStatus, required this.status});

  @override
  State<SelectStatus> createState() => _SelectStatusState();
}

class _SelectStatusState extends State<SelectStatus> {
  String? dropdownValue;
  late int currentStatus;

  @override
  void initState() {
    super.initState();
    currentStatus = widget.status;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: StatusExtension.fromInt(currentStatus),
      onSelected: (String? value) {
        widget.onSelectStatus(StatusList.indexOf(value!));

        setState(() {
          dropdownValue = value;
        });
      },
      dropdownMenuEntries:
          StatusList.map<DropdownMenuEntry<String>>((String status) {
        return DropdownMenuEntry<String>(value: status, label: status);
      }).toList(),
    );
  }
}
