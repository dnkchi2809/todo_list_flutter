import 'package:flutter/material.dart';
import '../modals/folder/add_new_folder_modal.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewFolderButton extends StatelessWidget {
  const AddNewFolderButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          useSafeArea: true,
          builder: (BuildContext context) {
            return const AddNewFolderModal();
          },
        );
      },
      style: IconButton.styleFrom(
        backgroundColor: Colors.blue.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      icon: const Icon(
        Icons.create_new_folder,
        size: 30,
        color: Colors.black54,
      ),
      tooltip: AppLocalizations.of(context)!.addNewFolder,
    );
  }
}