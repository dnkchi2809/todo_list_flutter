import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Home screen'),
        // CardComponent(cardTitle: 'Card Title', status: Status.Todo, recentUpdateDate: '2024/06/08',)
      ],
    );
  }
}
