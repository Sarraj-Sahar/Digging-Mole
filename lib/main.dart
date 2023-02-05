import 'package:flutter/material.dart';

import 'screens/firstScreen.dart';

void main(List<String> args) {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Flutter application',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: FirstScreen(),
  ));
}
