import 'package:flutter/cupertino.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import '../body_content.dart';

class BodyHook extends RecoilWidget{
  const BodyHook({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyContent();
  }
}