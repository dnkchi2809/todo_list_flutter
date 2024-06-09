import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'buttons/add_button.dart';
import 'hooks/dropdown_status.dart';

class AppBarWidget extends StatelessWidget{
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          children: [
            DropdownStatus(),
            SizedBox(width: 30),
            AddButton(),
          ],
        ),

      ],
    );
  }
}