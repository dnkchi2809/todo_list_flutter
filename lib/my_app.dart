import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/widgets/hooks/app_hook.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RecoilProvider(
      builder: (context, child) {
        return const AppHook();
      },
    );
  }
}
