import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../classes/folder.dart';
import '../../../utils/get_new_id.dart';
import '../../../utils/update_folder_list.dart';
import '../modal_title.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddNewFolderModal extends StatefulWidget {
  const AddNewFolderModal({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AddNewFolderModalState();
  }
}

class _AddNewFolderModalState extends State<AddNewFolderModal> {
  final TextEditingController folderNameController = TextEditingController();
  final TextEditingController folderDescriptionController =
      TextEditingController();

  String? _errorText;

  Future<void> addNewFolder() async {
    int newFolderId;
    final String name = folderNameController.text;
    final String description = folderDescriptionController.text;
    List taskIds = [];

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? folderList = prefs.getStringList('folders');
    folderList = folderList ?? [];

    var isValidFolder = validateFolder(folderList, name);

    if (!isValidFolder) return;

    newFolderId = getNewFolderId(prefs);

    final newFolder = Folder(newFolderId, name, description, taskIds);

    updateFolderList(newFolder);

    Navigator.pop(context);
  }

  bool validateFolder(folderList, inputName) {
    //check inputName not empty
    if (inputName.toString().isEmpty) {
      setState(() {
        _errorText = AppLocalizations.of(context)!.folderNameIsEmpty;
      });
      return false;
    }

    // Check if folder name already exists
    for (String folderJson in folderList) {
      Folder folder = Folder.fromJson(jsonDecode(folderJson));
      if (folder.name == inputName) {
        setState(() {
          _errorText = AppLocalizations.of(context)!.folderWithName +
              inputName +
              AppLocalizations.of(context)!.alreadyExist;
        });
        return false;
      }
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ModalTitle(AppLocalizations.of(context)!.addNewFolder),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: folderNameController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.folderName,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: const OutlineInputBorder(),
                      hintText: AppLocalizations.of(context)!.enterFolderName,
                      errorText: _errorText,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _errorText = null; // Clear error when user types
                      });
                    },
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: folderDescriptionController,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context)!.description,
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: const OutlineInputBorder(),
                      hintText:
                          AppLocalizations.of(context)!.enterFolderDescription,
                    ),
                    keyboardType: TextInputType.multiline,
                    minLines: 6,
                    maxLines: 10,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: 600,
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: addNewFolder,
                            child: Text(AppLocalizations.of(context)!.add),
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: SizedBox(
                          height: 40,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.grey,
                              foregroundColor: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(AppLocalizations.of(context)!.cancel),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
