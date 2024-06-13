import 'package:flutter_recoil/flutter_recoil.dart';

final languageState = Atom<String>(
  key: 'language_state',
  defaultValue: 'en',
);