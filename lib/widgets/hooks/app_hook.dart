import 'package:flutter/cupertino.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import '../../screens/app.dart';

class AppHook extends RecoilWidget{
  const AppHook({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen();
  }
}