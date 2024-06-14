import 'package:flutter_recoil/flutter_recoil.dart';

final statusState = Atom<int>(
  key: 'status_state',
  defaultValue: 0,
);
