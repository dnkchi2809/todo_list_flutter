import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../classes/folder.dart';

class SelectFolder extends StatefulWidget {
  final int folderId;
  final Function(int) onSelectFolder;

  const SelectFolder(
      {super.key, required this.onSelectFolder, required this.folderId});

  @override
  State<SelectFolder> createState() => _SelectFolderState();
}

class _SelectFolderState extends State<SelectFolder> {
  String? dropdownValue;
  late int currentFolderId;
  Future<List<String>>? _folderListFuture;

  @override
  void initState() {
    super.initState();
    currentFolderId = widget.folderId;
    _folderListFuture = _loadFolders();
  }

  Future<List<String>> _loadFolders() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('folders') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _folderListFuture,
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return const Text('No folder found');

          final List<Folder> folderList = snapshot.data!
              .map((folderJson) => Folder.fromJson(jsonDecode(folderJson)))
              .toList();

          var initialFolderName;

          for (var entry in folderList.asMap().entries) {
            if (entry.value.folderId == currentFolderId) {
              initialFolderName = entry.value.name;
            }
          }

          return DropdownMenu<String>(
            initialSelection: initialFolderName,
            onSelected: (String? value) {
              final selectedFolder =
                  folderList.firstWhere((folder) => folder.name == value);
              widget.onSelectFolder(selectedFolder
                  .folderId); // Call callback function with folderId

              setState(() {
                dropdownValue = value!;
              });
            },
            dropdownMenuEntries:
                folderList.map<DropdownMenuEntry<String>>((Folder folder) {
              return DropdownMenuEntry<String>(
                  value: folder.name, label: folder.name.toString());
            }).toList(),
          );
        });
  }
}
