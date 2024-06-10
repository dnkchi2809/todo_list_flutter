import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/folder.dart';
import '../models/folder_model.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return FolderScreenState();
  }
}

class FolderScreenState extends State<FoldersScreen> {
  late SharedPreferences prefs;
  List<Folder> folders = [];

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String>? storedFolders = prefs.getStringList('folders');
      if (storedFolders != null) {
        folders = storedFolders
            .map((folderJson) => Folder.fromJson(jsonDecode(folderJson)))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: folders.isNotEmpty ? ListView.builder(
          itemCount: folders.length,
          itemBuilder: (context, index) {
            return Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FolderModel(
                  folderName: folders[index].name,
                  // quantityTask: folders[index].quantity,
                ),
              ),
            );
          },
        ) : const Text('There is no folder found. Please create new folder'),
      ),
    );
  }
}
