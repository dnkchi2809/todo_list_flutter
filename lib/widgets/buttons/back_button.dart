import 'package:flutter/material.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/states/menu_state.dart';

class BackButtonInDetailScreen extends RecoilWidget {
  final currentMenuState = useRecoilState(menuState);

  BackButtonInDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: currentMenuState.data == "Detail",
      child: TextButton.icon(
        onPressed: () {
          currentMenuState.setData('Folders');
        },
        icon: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.blue,),
        label: const Text(
          'Back',
          style: TextStyle(color: Colors.blue, fontSize: 18),
        ),
      ),
    );
  }
}
