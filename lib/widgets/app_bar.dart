import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'buttons/add_new_folder_button.dart';
import 'buttons/add_new_task_button.dart';
import 'hooks/back_button_hook.dart';
import 'hooks/dropdown_status_hook.dart';
import 'hooks/switch_language_hook.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
            child: Align(
                alignment: Alignment.centerLeft, child: BackButtonHook())),
        Row(
          children: [
            DropdownStatusHook(),
            SizedBox(width: 30),
            AddNewTaskButton(),
            SizedBox(width: 20),
            AddNewFolderButton(),
            SizedBox(width: 10),
            SwitchLanguageHook(),
          ],
        ),
      ],
    );
  }
}
