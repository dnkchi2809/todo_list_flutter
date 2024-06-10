import 'package:flutter/material.dart';

/// Flutter code sample for [DropdownMenu].

const List<String> list = <String>['No folder', 'Two', 'Three', 'Four'];

class SelectFolder extends StatefulWidget {
  final int taskId;

  const SelectFolder({super.key, required this.taskId});

  @override
  State<SelectFolder> createState() => _SelectFolderState();
}

class _SelectFolderState extends State<SelectFolder> {
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      initialSelection: list.first,
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value);
      }).toList(),
    );
  }
}
