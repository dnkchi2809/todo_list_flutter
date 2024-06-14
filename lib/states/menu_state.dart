import 'package:flutter_recoil/flutter_recoil.dart';

final menuState = Atom<String>(
  key: 'menu_state',
  defaultValue: 'Home',
);
