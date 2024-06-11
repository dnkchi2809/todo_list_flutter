import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/folder.dart';
import '../models/folder_model.dart';

class FoldersScreen extends StatefulWidget {
  const FoldersScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _FolderScreenState();
  }
}

class _FolderScreenState extends State<FoldersScreen> {
  late SharedPreferences prefs;
  List<Folder> folders = [];

  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
    _startPolling();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
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

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 0), (timer) {
      _loadSharedPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 1200,
          child: folders.isNotEmpty
              ? GridView.builder(
                  itemCount: folders.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5, // 4 columns
                    crossAxisSpacing: 4.0, // Horizontal space between each item
                    mainAxisSpacing: 4.0, // Vertical space between each item
                  ),
                  itemBuilder: (context, index) {
                    final folder = folders[index];
                    return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: FolderModel(
                          folderName: folder.name,
                          folderDescription: folder.description,
                          folderQuantity: folder.taskIds.length,
                        ));
                  },
                )
              : const Text('There is no folder found. Please create new folder'),
        ),
      ),
    );
  }
}
