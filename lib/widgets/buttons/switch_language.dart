import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SwitchLanguage extends StatefulWidget {
  const SwitchLanguage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SwitchLanguageState();
  }
}

class _SwitchLanguageState extends State<SwitchLanguage> {
  late SharedPreferences prefs;
  late String localeString;
  late Timer _timer;

  @override
  void initState() {
    localeString = 'en';
    super.initState();
    _initSharedPreferences();
    _startPolling();
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
    localeString = prefs.getString('language') ?? 'en';
  }

  void _startPolling() {
    _timer = Timer.periodic(const Duration(seconds: 0), (timer) {
      _loadSharedPreferences();
    });
  }

  void switchLanguage() {
    prefs.getString('language') == 'vi'
        ? prefs.setString('language', 'en')
        : prefs.setString('language', 'vi');
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
