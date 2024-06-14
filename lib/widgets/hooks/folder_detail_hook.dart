import 'package:flutter/cupertino.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import '../../screens/folder_detail_screen.dart';

class FolderDetailHook extends RecoilWidget {
  const FolderDetailHook({super.key});

  @override
  Widget build(BuildContext context) {
    return FolderDetailScreen();
  }
}
