import 'package:flutter_recoil/flutter_recoil.dart';

final statusState = Atom<String>(
  key: 'status_state',
  defaultValue: 'All',
);