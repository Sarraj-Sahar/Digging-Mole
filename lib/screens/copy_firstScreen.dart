import 'package:digging_mole/screens/levelone.dart';
import 'package:digging_mole/utils/holesStatus.dart';
import 'package:flutter/material.dart';
import 'package:conditioned/conditioned.dart';
import '../components/customPageRoute.dart';
import '../components/hole.dart';

class FirstScreen extends StatefulWidget {
  // FirstScreen({required this.currentMap});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  // late String currentMap;
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
    // if (currentMap == "firstScreen")

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/assets/bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              //
              // game stats and menu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  // number of bombs
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "6",
                        style: TextStyle(fontSize: 40),
                      ),
                      Text("B O M B S"),
                    ],
                  ),
                  //
                  // restart button
                  Card(
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          _holeList = _generateHoleList();
                        });
                      },
                      icon: const Icon(Icons.refresh),
                    ),
                  ),
                  //

                  //

                  // time left
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "0",
                        style: TextStyle(fontSize: 40),
                      ),
                      Text("T I M E"),
                    ],
                  ),

                  //
                ],
              ),
              //
              // game body
              _FirstScreenBody(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _FirstScreenBody() {
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
                  "lib/assets/new_unselected.png",
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
                  Navigator.of(context).push(
                      // MaterialPageRoute(
                      //      builder: (context) => LevelOne(),
                      // ),
                      CustomPageRoute(
                    child: LevelOne(),
                  ));
                },
              ),
            ),
            Case(
              _selectedHoleIndex == index,
              // && h.status == HoleStatus.selected,
              builder: () => Image.asset("lib/assets/new_selected.png"),
            ),
          ],
          defaultBuilder: () => Container(),
        ),
      ),
    );
  }
}
