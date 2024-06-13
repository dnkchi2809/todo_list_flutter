import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/states/language_state.dart';

class SwitchLanguage extends StatefulWidget {
  SwitchLanguage({super.key});
  final RecoilNotifier languageSelected = useRecoilState(languageState);

  @override
  State<StatefulWidget> createState() {
    return _SwitchLanguageState();
  }
}

class _SwitchLanguageState extends State<SwitchLanguage> {
  late RecoilNotifier languageAppbarSelected;

  @override
  void initState() {
    languageAppbarSelected = widget.languageSelected;

    super.initState();
  }

  void switchLanguage() {
    languageAppbarSelected.data == 'en'
        ? languageAppbarSelected.setData('vi')
        : languageAppbarSelected.setData('en');
    print(languageAppbarSelected.data);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: switchLanguage,
      child: Text(
        AppLocalizations.of(context)!.language,
        style: TextStyle(color: Colors.blue, fontSize: 18),
      ),
    );
  }
}