import 'package:flutter/cupertino.dart';
import 'package:flutter_recoil/flutter_recoil.dart';
import 'package:todo_list_flutter/components/modal_title.dart';

import '../../pages/folders_screen.dart';
import '../../pages/home_screen.dart';
import '../body_content.dart';

class Body extends RecoilWidget{
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return BodyContent();
  }
}