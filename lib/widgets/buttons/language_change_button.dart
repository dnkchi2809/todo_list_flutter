import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_recoil/flutter_recoil.dart';

import '../../states/language_state.dart';

class LanguageChange extends RecoilWidget {
  final languageSelected = useRecoilState(languageState);

  LanguageChange({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(15), minimumSize: Size(150, 50)),
        onPressed: () {
          languageSelected.setData(
              languageSelected.data == 'English' ? 'Vietnamese' : 'English');
        },
        child: Text(
          languageSelected.data,
          style: const TextStyle(
            color: Colors.green,
            fontSize: 18,
          ),
        ));
  }
}
