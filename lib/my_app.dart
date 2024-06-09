import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/components/app_bar.dart';
import 'package:todo_list_flutter/components/hooks/body.dart';

import 'components/hooks/menu.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return RecoilProvider(
      builder: (context, child) {
        return MaterialApp(
          home: Scaffold(
            appBar: new AppBar(
              title: const AppBarWidget(),
            ),
            body: const Body(),
            drawer: const Menu(),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}