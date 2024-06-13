import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_flutter/classes/folder.dart';
import '../../../utils/update_folder_list.dart';
import '../../modal_title.dart';

class EditFolderModal extends StatefulWidget {
  final Folder folderRequest;

  const EditFolderModal({super.key, required this.folderRequest});

  @override
  State<StatefulWidget> createState() {
    return _EditFolderModalState();
  }
}

class _EditFolderModalState extends State<EditFolderModal> {
  late Folder currentFolder;
  final TextEditingController folderNameController = TextEditingController();
  final TextEditingController folderDescriptionController =
      TextEditingController();

  String? _errorText;

  String? deadline;
  int? selectedFolderId;
  int? selectedStatus;

  @override
  void initState() {
    super.initState();
    currentFolder = widget.folderRequest;
    folderNameController.text = currentFolder.name;
    folderDescriptionController.text = currentFolder.description;
  }

  Future<void> editFolder() async {
    final String name = folderNameController.text;
    final String description = folderDescriptionController.text;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? folderList = prefs.getStringList('folders');
    folderList = folderList ?? [];

    var isValidFolder = validateFolder(folderList, name);

    if (!isValidFolder) return;

    final updateFolder = Folder(
        currentFolder.folderId, name, description, currentFolder.taskIds);

    updateFolderList(updateFolder);

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
            const ModalTitle('Update folder'),
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
                            onPressed: editFolder,
                            child: const Text('Update'),
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