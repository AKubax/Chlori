import 'package:flutter/material.dart';
import 'Views/TheApp.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      primaryColor: Colors.white,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),

    home: TheApp(),
  ));
}



