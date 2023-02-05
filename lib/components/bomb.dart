import 'package:flutter/material.dart';
import 'package:conditioned/conditioned.dart';
import 'package:digging_mole/utils/holesStatus.dart';

class BombView extends StatelessWidget {
  bool revealed;
  final function;

  BombView({required this.revealed, required this.function});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        margin: EdgeInsets.all(5),
        child: revealed
            ? Image.asset(
                "lib/assets/bomb.png",
              )
            : Image.asset(
                "lib/assets/new_unselected.png",
              ),
      ),
    );
  }
}
