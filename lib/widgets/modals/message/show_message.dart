import 'package:flutter/material.dart';

ScaffoldMessengerState showMessage(
    BuildContext context, String message, Color color) {
  return ScaffoldMessenger.of(context)
    ..removeCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color,
      duration: const Duration(milliseconds: 2000),
    ));
}
