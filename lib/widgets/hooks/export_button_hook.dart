import 'package:flutter/cupertino.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/widgets/buttons/export_button.dart';

class ExportButtonHook extends RecoilWidget{
  const ExportButtonHook({super.key});

  @override
  Widget build(BuildContext context) {
    return ExportButton();
  }
}