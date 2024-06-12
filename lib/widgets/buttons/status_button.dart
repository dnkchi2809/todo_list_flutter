import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';

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
        const Text(
          'Status: ',
          style: TextStyle(fontSize: 16),
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
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
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
