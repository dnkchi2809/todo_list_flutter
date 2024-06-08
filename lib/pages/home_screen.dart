import 'package:flutter/cupertino.dart';

import '../components/card_component.dart';
import '../components/screen_title.dart';
import '../const.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('Home screen'),
        CardComponent(cardTitle: 'Card Title', status: Status.Todo, recentUpdateDate: '2024/06/08',)
      ],

    );
  }
}