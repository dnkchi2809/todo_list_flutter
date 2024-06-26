import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/states/language_state.dart';
import 'package:todo_list_flutter/widgets/app_bar.dart';
import 'package:todo_list_flutter/widgets/hooks/body_hook.dart';
import 'package:todo_list_flutter/widgets/hooks/menu_hook.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AppScreen extends StatelessWidget {
  AppScreen({super.key});

  final RecoilNotifier languageSelected = useRecoilState(languageState);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale(languageSelected.data),
      home: Scaffold(
        appBar: new AppBar(
          title: const AppBarWidget(),
        ),
        body: const BodyHook(),
        drawer: const MenuHook(),
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}
