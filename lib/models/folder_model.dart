import 'package:flutter/material.dart';

class FolderModel extends StatelessWidget {
  final String folderName;
  final String folderDescription;
  final int folderQuantity;

  const FolderModel(
      {super.key,
      required this.folderName,
      required this.folderDescription,
      required this.folderQuantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 2.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            title: Text(
              folderName,
              style: TextStyle(
                  color: Colors.blue.shade900, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              folderDescription,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          ListTile(
              title: Text(
            'Tasks: $folderQuantity',
            style: const TextStyle(fontSize: 12),
          ))
        ],
      ),
    );
  }
}
