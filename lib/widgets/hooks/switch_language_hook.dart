import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import '../buttons/switch_language.dart';

class SwitchLanguageHook extends RecoilWidget{
  const SwitchLanguageHook({super.key});

  @override
  Widget build(BuildContext context) {
    return SwitchLanguage();
  }
}