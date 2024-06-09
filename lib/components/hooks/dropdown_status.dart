import 'package:flutter/cupertino.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/components/buttons/status_button.dart';

class DropdownStatus extends RecoilWidget{
  const DropdownStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonExample();
  }
}