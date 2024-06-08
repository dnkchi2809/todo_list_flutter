import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(MaterialApp(
    home: SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Todo List'),
        ),
        body: const Text('Body'),
      ),
    ),
    theme: ThemeData(
    ),
    debugShowCheckedModeBanner: false,
  ));
}
