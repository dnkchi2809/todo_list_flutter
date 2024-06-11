import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';

import '../../const.dart';
import '../../states/status_state.dart';

class SelectStatus extends RecoilWidget {
  final statusSelected = useRecoilState(statusState);

  SelectStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Status: ',
          style: TextStyle(fontSize: 16),
        ),
        DropdownMenu<String>(
          onSelected: (String? value) {
            statusSelected
                .setData(value!.isNotEmpty ? value : statusSelected.data);
          },
          dropdownMenuEntries:
          StatusList.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry<String>(value: value, label: value);
          }).toList(),
        ),
      ],
    );
  }
}
