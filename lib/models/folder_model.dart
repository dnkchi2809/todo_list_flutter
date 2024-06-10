import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FolderModel extends StatelessWidget {
  final String folderName;
  // final int quantityTask;

  const FolderModel({super.key, required this.folderName});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 200,
        height: 100,
        color: Colors.lightBlueAccent,
        child: Column(children: [
          Text(
            folderName,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          // Text(quantityTask.toString()),
        ]));
  }
}
