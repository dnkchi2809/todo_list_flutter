import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/widgets/app_bar.dart';
import 'package:todo_list_flutter/widgets/hooks/body_hook.dart';
import 'package:todo_list_flutter/widgets/hooks/menu_hook.dart';

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
            body: const BodyHook(),
            drawer: const MenuHook(),
          ),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}