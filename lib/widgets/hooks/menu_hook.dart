import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import '../drawer.dart';

class MenuHook extends RecoilWidget {
  const MenuHook({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerWidget();
  }
}
