import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'buttons/add_new-folder_button.dart';
import 'buttons/add_new-task_button.dart';
import 'hooks/dropdown_status.dart';

class AppBarWidget extends StatelessWidget {
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
            AddNewTaskButton(),
            SizedBox(width: 20),
            AddNewFolderButton(),
          ],
        ),
      ],
    );
  }
}
