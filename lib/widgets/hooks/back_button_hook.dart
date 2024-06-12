import 'package:flutter/cupertino.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import '../buttons/back_button.dart';

class BackButtonHook extends RecoilWidget{
  const BackButtonHook({super.key});

  @override
  Widget build(BuildContext context) {
    return BackButtonInDetailScreen();
  }
}