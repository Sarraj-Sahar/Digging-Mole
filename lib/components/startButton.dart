import 'package:flutter/material.dart';

Widget startButton() {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
      ),
      onPressed: () {},
      child: const Text(
        "S T A R T",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
