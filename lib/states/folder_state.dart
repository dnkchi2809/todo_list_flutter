import 'package:flutter_recoil/flutter_recoil.dart';

final folderState = Atom<int>(
  key: 'folder_state',
  defaultValue: -1,
);