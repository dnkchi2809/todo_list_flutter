import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';

import 'components/menu.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return RecoilProvider(
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Recoil Demo',
          home: Menu(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}