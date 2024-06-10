import 'package:flutter/material.dart';

class ModalTitle extends StatelessWidget{
  final String title;

  const ModalTitle(this.title, {super.key, });

  @override
  Widget build(BuildContext context) {
    return Text(title,
        style: const TextStyle(
          color: Colors.blueAccent,
          fontSize: 20,
        )
    );
  }
}