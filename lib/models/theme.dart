import 'package:flutter/material.dart';

class MyTheme {
  Color? color;
  String? headerImage;

  MyTheme(this.color, this.headerImage);

}

List<MyTheme> themes =[
  MyTheme(Color(0xFF0A540F), 'assets/1.jpg'),
  MyTheme(Color(0xFF053F6B), 'assets/2.jpg'),
  MyTheme(Color(0xFF880A0A), 'assets/3.jpg'),
];