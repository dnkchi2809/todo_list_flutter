import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'classes/folder.dart';
import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeSharedPreferences();
  runApp(const MyApp());
}

Future<void> initializeSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.clear();

  if (!prefs.containsKey('folders')) {
    List<String>? folderList = [];

    final newFolder = Folder(
        0,
        'Default folder',
        'This is a default folder',
        []);
    folderList.add(jsonEncode(newFolder.toJson()));

    await prefs.setStringList('folders', folderList.cast<String>());
  }
}