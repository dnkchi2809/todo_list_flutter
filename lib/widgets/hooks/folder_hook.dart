import 'package:flutter/cupertino.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import '../../classes/folder.dart';
import '../../models/folder_model.dart';

class FolderHook extends RecoilWidget {
  final Folder folder;

  const FolderHook({super.key, required this.folder});

  @override
  Widget build(BuildContext context) {
    return FolderModel(
      folder: folder,
    );
  }
}
