import 'package:flutter/material.dart';
import '../../../classes/folder.dart';
import '../../../utils/update_folder_list.dart';
import '../../modal_title.dart';

class DeleteFolderModal extends StatefulWidget {
  final Folder folderRequest;

  const DeleteFolderModal({super.key, required this.folderRequest});

  @override
  State<StatefulWidget> createState() {
    return _DeleteFolderModalState();
  }
}

class _DeleteFolderModalState extends State<DeleteFolderModal> {
  late Folder currentFolder;

  @override
  void initState() {
    super.initState();
    currentFolder = widget.folderRequest;
  }

  void deleteFolder() async {
    removeInFolderList(currentFolder.folderId, context);
    
    Navigator.pop(context);
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
            ModalTitle('Delete this folder: ${widget.folderRequest.name}'),
            const SizedBox(height: 30),
            const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning,
                  color: Colors.red,
                ),
                Text(
                  'This action cannot be undone!!!',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 400,
              height: 40,
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 40,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: deleteFolder,
                        child: const Text('Delete'),
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
      ),
    );
  }
}
