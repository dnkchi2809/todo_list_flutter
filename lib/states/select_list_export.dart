import 'package:flutter_recoil/flutter_recoil.dart';

final selectListExportState = Atom<List>(
  key: 'select_list_export_state',
  defaultValue: [],
);