import 'package:digging_mole/utils/holesStatus.dart';
import 'package:flutter/material.dart';
import 'package:conditioned/conditioned.dart';
import '../components/hole.dart';

class LevelOne extends StatefulWidget {
  @override
  State<LevelOne> createState() => _LevelOneState();
}

class _LevelOneState extends State<LevelOne> {
  List<Hole> _holeList = [];

  // hole_list with 8 holes
  List<Hole> _generateHoleList() {
    List<Hole> holeList = [];
    for (int i = 0; i < 8; i++) {
      holeList.add(Hole(HoleStatus.none));
    }
    return holeList;
  }

  // to keep track of the selected hole index
  late int _selectedHoleIndex;

  @override
  void initState() {
    super.initState();
    _holeList = _generateHoleList();
    //assign this value to half the length of the hole list
    _selectedHoleIndex = 5;
  }

  @override
  Widget build(BuildContext context) {
    // if (currentMap == "LevelOne")

    return Scaffold(
      body: SafeArea(
        child: Container(
          // make background of container an image
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("../assets/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: Text("Level 1"),
              ),
              _LevelOneBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _LevelOneBody() {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10),
      // child: Card(
      child: GridView.count(
        // Create a grid with 2 columns
        // change the scrollDirection to horizontal, this produces 2 rows.
        crossAxisCount: 4,
        shrinkWrap: true,
        children: _holeList.map((Hole v) {
          return _HoleView(v, _holeList.indexOf(v));
        }).toList(),
      ),
      // ),
    );
  }

//////// Hole View
  Widget _HoleView(Hole h, int index) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(20),
        child: Conditioned(
          cases: [
            Case(
              _selectedHoleIndex != index && h.status == HoleStatus.none,
              builder: () => GestureDetector(
                child: Image.asset(
                  "../../assets/hole.png",
                  width: 150,
                  height: 150,
                ),

                // on tap gesture : add play sound effect
                onTap: () {
                  // setState(() {
                  //   h.status = HoleStatus.selected;
                  //   // _whacked = _whacked + 1;
                  //   // _playWhackSound();
                  // });

                  setState(() {
                    if (_selectedHoleIndex != null) {
                      _holeList[_selectedHoleIndex].status = HoleStatus.none;
                    }
                    _selectedHoleIndex = index;
                    h.status = HoleStatus.selected;
                  });
                },

                // on double tap
                onDoubleTap: () {
                  setState(() {});
                },
              ),
            ),
            Case(
              _selectedHoleIndex == index,
              // && h.status == HoleStatus.selected,
              builder: () => Stack(children: [
                Image.asset("../assets/hole_selected.png"),
                Align(
                    alignment: Alignment.topRight,
                    child: Image.asset("../assets/mole.png")),
              ]),
            ),
          ],
          defaultBuilder: () => Container(),
        ),
      ),
    );
  }
}
