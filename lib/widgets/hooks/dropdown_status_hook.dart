import 'package:flutter/cupertino.dart';
import 'package:flutter_recoil/flutter_recoil.dart';

import '../buttons/status_button.dart';

class DropdownStatusHook extends RecoilWidget {
  const DropdownStatusHook({super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownStatusButton();
  }
}
