import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_flutter/widgets/app_bar.dart';
import 'package:todo_list_flutter/widgets/hooks/body_hook.dart';
import 'package:todo_list_flutter/widgets/hooks/menu_hook.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {
  late SharedPreferences prefs;
  late String localeString;
  late Timer _timer;

  @override
  void initState() {
    localeString = 'en';
    _initSharedPreferences();
    _startPolling();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Future<void> _initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      localeString = prefs.getString('language') ?? 'en';
    });

  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 0), (timer) {
      _loadSharedPreferences();
    });
  }

  @override
  Widget build(BuildContext context) {
    return RecoilProvider(
      builder: (context, child) {
        return MaterialApp(
          locale: Locale(localeString),
          home: Scaffold(
            appBar: AppBar(
              title: const AppBarWidget(),
            ),
            body: const BodyHook(),
            drawer: const MenuHook(),
          ),
          debugShowCheckedModeBanner: false,
          supportedLocales: const [
            Locale('en', ''), // English
            Locale('vi', ''), // Vietnamese
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
        );
      },
    );
  }
}