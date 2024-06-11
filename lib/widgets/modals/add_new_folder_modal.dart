import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../classes/folder.dart';
import '../modal_title.dart';

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

    // await prefs.remove('folders');
    List<String>? folderList = prefs.getStringList('folders');
    folderList = folderList ?? [];

    var isValidFolder = validateFolder(folderList, name);

    if (!isValidFolder) return;

    newFolderId = getNewFolderId(folderList);

    final newFolder = Folder(newFolderId, name, description, taskIds);
    print(newFolder);

    folderList.add(jsonEncode(newFolder.toJson()));

    await prefs.setStringList('folders', folderList);

    Navigator.pop(context);
  }

  bool validateFolder(folderList, inputName) {
    //check inputName not empty
    if (inputName.toString().isEmpty) {
      setState(() {
        _errorText = 'Folder name is not empty.';
      });
      return false;
    }

    // Check if folder name already exists
    for (String folderJson in folderList) {
      Folder folder = Folder.fromJson(jsonDecode(folderJson));
      if (folder.name == inputName) {
        setState(() {
          _errorText = 'Folder with the name "$inputName" already exists.';
        });
        return false;
      }
    }

    return true;
  }

  int getNewFolderId(folderList){
    var lastFolder =
    Folder.fromJson(jsonDecode(folderList[folderList.length - 1]));
    var lastFolderIdInList = lastFolder.folderId;
    return lastFolderIdInList + 1;
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
            const ModalTitle('Add new folder'),
            const SizedBox(height: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 600,
                  child: TextField(
                    controller: folderNameController,
                    decoration: InputDecoration(
                      labelText: 'Folder name',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: const OutlineInputBorder(),
                      hintText: 'Enter folder name',
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
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      border: OutlineInputBorder(),
                      hintText: 'Enter folder description (optional)',
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
                            child: const Text('Add'),
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
                            child: const Text('Cancel'),
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
