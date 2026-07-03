import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todoapp/home.dart';

void main() {
  runApp(todo());
}

class todo extends StatelessWidget {
  @override
  Widget build(BuildContext content) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo App',
      home: home(),
    );
  }
}