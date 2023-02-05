import 'package:flutter/material.dart';
import 'package:conditioned/conditioned.dart';
import 'package:digging_mole/utils/holesStatus.dart';

// old
class Hole {
  var status;

  Hole(this.status);
}
//////////

class HoleView extends StatelessWidget {
  final child;
  final selected;
  bool revealed;
  final function;
  final num_surrounding_Bombs;

  HoleView(
      {required this.child,
      required this.revealed,
      required this.selected,
      required this.function,
      required this.num_surrounding_Bombs});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
          margin: EdgeInsets.all(5),
          child: Conditioned(cases: [
            // unselected and unrevealed
            Case(
              selected != child,
              builder: () =>
                  //  Stack(children: [
                  Image.asset(
                "lib/assets/new_unselected.png",
              ),
              // Text(child.toString());
              // ]),
            ),

            /////////////////////////////////
            //unselected but revealed
            // case 0 surrounding bombs
            Case(
              selected != child &&
                  revealed == true &&
                  num_surrounding_Bombs == 0,
              builder: () =>
                  //  Stack(children: [
                  Image.asset(
                "lib/assets/alerts/0_alrt.png",
              ),
              // Text(child.toString());
              // ]),
            ),

// case 1 surrounding bombs
            Case(
              selected != child &&
                  revealed == true &&
                  num_surrounding_Bombs == 1,
              builder: () =>
                  //  Stack(children: [
                  Image.asset(
                "lib/assets/alerts/1_alrt.png",
              ),
              // Text(child.toString());
              // ]),
            ),
            ////////////////////////////////////
            // selected
            Case(
              selected == child && num_surrounding_Bombs == 1,
              builder: () => Image.asset(
                "lib/assets/mole_alerts/mole_1.png",
                width: 200,
                height: 200,
              ),
            ),
            Case(
              selected == child && num_surrounding_Bombs == 2,
              builder: () => Image.asset(
                "lib/assets/mole_alerts/mole_2.png",
                width: 200,
                height: 200,
              ),
            ),
            Case(
              selected == child && num_surrounding_Bombs == 3,
              builder: () => Image.asset(
                "lib/assets/mole_alerts/mole_3.png",
                width: 200,
                height: 200,
              ),
            ),
            Case(
              selected == child && num_surrounding_Bombs == 4,
              builder: () => Image.asset(
                "lib/assets/mole_alerts/mole_4.png",
                width: 200,
                height: 200,
              ),
            ),
            Case(
              selected == child && num_surrounding_Bombs == 0,
              builder: () => Image.asset(
                "lib/assets/mole_alerts/mole_0.png",
                // should change to
                // "lib/assets/new_selected.png",
              ),
            ),
            Case(
              selected == child,
              builder: () => Image.asset(
                "lib/assets/new_selected.png",
              ),
            ),
          ], defaultBuilder: () => Container())

          // child: Conditioned(
          //   cases: [
          //     Case(
          //       _selectedHoleIndex != index && h.status == HoleStatus.none,
          //       builder: () => GestureDetector(
          //         child: Image.asset(
          //           "lib/assets/new_unselected.png",
          //           width: 150,
          //           height: 150,
          //         ),

          //         // on tap gesture : add play sound effect
          //         onTap: () {
          //           // setState(() {
          //           //   h.status = HoleStatus.selected;
          //           //   // _whacked = _whacked + 1;
          //           //   // _playWhackSound();
          //           // });

          //           setState(() {
          //             if (_selectedHoleIndex != null) {
          //               _holeList[_selectedHoleIndex].status = HoleStatus.none;
          //             }
          //             _selectedHoleIndex = index;
          //             h.status = HoleStatus.selected;
          //           });
          //         },

          //         // on double tap
          //         onDoubleTap: () {
          //           Navigator.of(context).push(
          //               // MaterialPageRoute(
          //               //      builder: (context) => LevelOne(),
          //               // ),
          //               CustomPageRoute(
          //             child: LevelOne(),
          //           ));
          //         },
          //       ),
          //     ),
          //     Case(
          //       _selectedHoleIndex == index,
          //       // && h.status == HoleStatus.selected,
          //       builder: () => Image.asset("lib/assets/new_selected.png"),
          //     ),
          //   ],
          //   defaultBuilder: () => Container(),
          // ),
          ),
    );
  }
}
