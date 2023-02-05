import 'package:digging_mole/components/bomb.dart';
import 'package:digging_mole/screens/levelone.dart';
import 'package:digging_mole/screens/secondScreen.dart';
import 'package:digging_mole/utils/holesStatus.dart';
import 'package:flutter/material.dart';
import 'package:conditioned/conditioned.dart';
import '../components/customPageRoute.dart';
import '../components/hole.dart';

class FirstScreen extends StatefulWidget {
  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
// 1.  variables
  int numberOfSquares = 3 * 3;
  int numberInEachRow = 3;

// 2. [number of bombs around , revealed = true / false ] : exp : [2, false];
// just declare an empty list ==> we will "fill" it with desired squares once the
// app is intialized
  var squareStatus = [];

//old~ to keep track of the selected hole index
  late int _selectedHoleIndex;

//3. bomb locations : specify where bombs are located
  final List<int> bombLocation = [3];

// all bombs reveal if one bomb is selected
  bool bombsRevealed = false;

  // functions

// normal press
  void revealBoxnumber(int index) {
    //part 1 is revealing the current box itself if
    // it's : 1 , 2 ,3 ==> meaning that number (indicator number) is NOT 0
    // 1 = 1 bomb around , 2 = 2 bombs around

    if (squareStatus[index][0] != 0) {
      setState(() {
        squareStatus[index][1] = true;
        _selectedHoleIndex = index;
      });
    }

    //part 2 is revealing the other "empty" squares if they don't indicate anything
    // else if current box IS 0 ==> HAS 0 bombs around

    else if (squareStatus[index][0] == 0) {
      //reveal the current box, and the 8 surrounding it

      setState(() {
        //the box
        squareStatus[index][1] = true;

        //the 8 surrounding boxes, unless you're on a wall

        //1. reveal left box , unless you're a wall
        if (index % numberInEachRow != 0) {
          // if next box isn't revealed yet and it ia a 0 , then recurse
          if (squareStatus[index - 1][0] == 0 &&
              squareStatus[index - 1][1] == false) {
            revealBoxnumber(index - 1);
          }

          //reveal left box
          squareStatus[index - 1][1] = true;
        }

        // 2.top top left box
        if (index % numberInEachRow != 0 && index >= numberInEachRow) {
          // if next box isn't revealed yet and it ia a 0 , then recurse
          if (squareStatus[index - 1 - numberInEachRow][0] == 0 &&
              squareStatus[index - 1 - numberInEachRow][1] == false) {
            revealBoxnumber(index - 1 - numberInEachRow);
          }

          squareStatus[index - 1 - numberInEachRow][1] = true;
        }

        //3. top box
        if (index >= numberInEachRow) {
          // if next box isn't revealed yet and it ia a 0 , then recurse
          if (squareStatus[index - numberInEachRow][0] == 0 &&
              squareStatus[index - numberInEachRow][1] == false) {
            revealBoxnumber(index - numberInEachRow);
          }

          squareStatus[index - numberInEachRow][1] = true;
        }

        //4. top right box
        if (index >= numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          // if next box isn't revealed yet and it ia a 0 , then recurse
          if (squareStatus[index + 1 - numberInEachRow][0] == 0 &&
              squareStatus[index + 1 - numberInEachRow][1] == false) {
            revealBoxnumber(index + 1 - numberInEachRow);
          }

          squareStatus[index + 1 - numberInEachRow][1] = true;
        }

        //5. right box
        if (index % numberInEachRow != numberInEachRow - 1) {
          // if next box isn't revealed yet and it ia a 0 , then recurse
          if (squareStatus[index + 1][0] == 0 &&
              squareStatus[index + 1][1] == false) {
            revealBoxnumber(index + 1);
          }

          squareStatus[index + 1][1] = true;
        }

        //6. bottom right box
        if (index < numberInEachRow &&
            index % numberInEachRow != numberInEachRow - 1) {
          // if next box isn't revealed yet and it ia a 0 , then recurse
          if (squareStatus[index + 1 + numberInEachRow][0] == 0 &&
              squareStatus[index + 1 + numberInEachRow][1] == false) {
            revealBoxnumber(index + 1 + numberInEachRow);
          }

          squareStatus[index + 1 + numberInEachRow][1] = true;
        }

        //7. bottom box
        if (index < numberOfSquares - numberInEachRow) {
          // if next box isn't revealed yet and it ia a 0 , then recurse
          if (squareStatus[index + numberInEachRow][0] == 0 &&
              squareStatus[index + numberInEachRow][1] == false) {
            revealBoxnumber(index + numberInEachRow);
          }

          squareStatus[index + numberInEachRow][1] = true;
        }

        //8. bottom left  box
        if (index < numberOfSquares - numberInEachRow &&
            index % numberInEachRow != 0) {
          // if next box isn't revealed yet and it ia a 0 , then recurse
          if (squareStatus[index - 1 + numberInEachRow][0] == 0 &&
              squareStatus[index - 1 + numberInEachRow][1] == false) {
            revealBoxnumber(index - 1 + numberInEachRow);
          }

          squareStatus[index - 1 + numberInEachRow][1] = true;
        }
      });
    }
  }

// scan bombs
  void scanBombs() {
    for (int i = 0; i < numberOfSquares; i++) {
      // there are no bombs around initially
      int numberOfBombsAround = 0;

      /*
      check each square to see if it has bombs around it 
      there are 8 surrounding squares to check 
       */

      //1. check square to left unless it is on the very first column
      if (bombLocation.contains(i - 1) && i % numberInEachRow != 0) {
        numberOfBombsAround++;
      }

      //2. check square to top left unless it is
      //on the very first column or first row
      if (bombLocation.contains(i - 1 - numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i >= numberInEachRow) {
        numberOfBombsAround++;
      }

      //3. check square to top , unless it is in the first row
      if (bombLocation.contains(i - numberInEachRow) && i >= numberInEachRow) {
        numberOfBombsAround++;
      }

      //4. check square to top right, unless it is in the first row or last column
      if (bombLocation.contains(i + 1 - numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i >= numberInEachRow - 1) {
        numberOfBombsAround++;
      }

      //5. check square to right unless it is on the last column
      if (bombLocation.contains(i + 1) &&
          i % numberInEachRow != numberInEachRow - 1) {
        numberOfBombsAround++;
      }

      //6. check square to bottom right, unless it is in the last row or last column
      if (bombLocation.contains(i + 1 + numberInEachRow) &&
          i % numberInEachRow != numberInEachRow - 1 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      //7. check square to bottom , unless it is in the first row
      if (bombLocation.contains(i + numberInEachRow) &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      //8. check square to bottom left, unless it is in the last row or first column
      if (bombLocation.contains(i - 1 + numberInEachRow) &&
          i % numberInEachRow != 0 &&
          i < numberOfSquares - numberInEachRow) {
        numberOfBombsAround++;
      }

      // finally add total number of bombs around to squareStatus[]

      setState(() {
        squareStatus[i][0] = numberOfBombsAround;
      });
    }
  }

// player lost or won
// lost
  void playerLost() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.grey[700],
            title: const Center(
              child: Text(
                "YOU LOST ",
                style: TextStyle(color: Colors.white),
              ),
            ),
            actions: [
              MaterialButton(
                color: Colors.grey[100],
                onPressed: () {
                  restartGame();
                  Navigator.pop(context);
                },
                child: Icon(Icons.refresh),
              )
            ],
          );
        });
  }

  // restart game
  void restartGame() {
    setState(() {
      bombsRevealed = false;
      for (int i = 0; i < numberOfSquares; i++) {
        squareStatus[i][1] = false;
      }
    });
  }

// won
  void playerWon() {
    Navigator.of(context).push(
        // MaterialPageRoute(builder: (context) => LevelOne(),),
        CustomPageRoute(
      child: SecondScreen(),
    ));
  }

// check winner
  void checkWinner() {
    //check how many boxes yet to reveal
    int unrevealedBoxes = 0;
    for (int i = 0; i < numberOfSquares; i++) {
      if (squareStatus[i][1] == false) {
        unrevealedBoxes++;
      }
    }

    // if this number = number of bombs , then player wins
    if (unrevealedBoxes == bombLocation.length) {
      playerWon();
    }
  }

  @override
  void initState() {
    super.initState();

    //2. at init , all squares should have 0 bombs around them
    for (int i = 0; i < numberOfSquares; i++) {
      squareStatus.add([0, false]);
    }
    _selectedHoleIndex = 0;

    scanBombs();
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
                    children: [
                      Text(
                        bombLocation.length.toString(),
                        style: TextStyle(fontSize: 40),
                      ),
                      Text("B O M B S"),
                    ],
                  ),
                  //
                  // restart button
                  GestureDetector(
                    onTap: restartGame,
                    child: Card(
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            // _holeList = _generateHoleList();
                          });
                        },
                        icon: const Icon(Icons.refresh),
                      ),
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

//// New FirstScreenBody
  Widget _FirstScreenBody() {
    return Expanded(
      child: GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: numberInEachRow),
          itemBuilder: (context, index) {
            return Conditioned(cases: [
              Case(
                bombLocation.contains(index),
                builder: () => BombView(
                  // revealed: squareStatus[index][1],
                  revealed: bombsRevealed,

                  // if user taps on bomb ==> game over
                  function: () {
                    setState(() {
                      bombsRevealed = true;
                    });
                    playerLost();
                  },
                ),
              ),
              // normal square
              Case(
                _selectedHoleIndex != index,
                builder: () => HoleView(
                  // child: index % numberOfSquares, -> to check that squares
                  //in the first column have no squares on their left
                  //
                  // child: squareStatus[index][0], //1 if square is surrounded by bomb , zero if not
                  child: index,
                  revealed: squareStatus[index][1],
                  selected: _selectedHoleIndex,
                  num_surrounding_Bombs: squareStatus[index][0],
                  // user taps normal hole => reveal it
                  function: () {
                    revealBoxnumber(index);
                    checkWinner();
                  },
                ),
              ),

              // selected square
              Case(
                _selectedHoleIndex == index,
                builder: () => HoleView(
                  child: index,
                  revealed: squareStatus[index][1],
                  selected: _selectedHoleIndex,
                  num_surrounding_Bombs: squareStatus[index][0],
                  function: () {},
                ),
              ),
            ], defaultBuilder: () => Container());

            // HoleView(
            //   child: index,
            // );
          }),
    );
  }

//////
//////// Hole View
  // Widget _HoleView(Hole h, int index) {
  //   return Center(
  //     child: Container(
  //       margin: EdgeInsets.all(20),
  //       child: Conditioned(
  //         cases: [
  //           Case(
  //             _selectedHoleIndex != index && h.status == HoleStatus.none,
  //             builder: () => GestureDetector(
  //               child: Image.asset(
  //                 "lib/assets/new_unselected.png",
  //                 width: 150,
  //                 height: 150,
  //               ),

  //               // on tap gesture : add play sound effect
  //               onTap: () {
  //                 setState(() {
  //                   if (_selectedHoleIndex != null) {
  //                     _holeList[_selectedHoleIndex].status = HoleStatus.none;
  //                   }
  //                   _selectedHoleIndex = index;
  //                   h.status = HoleStatus.selected;
  //                 });
  //               },

  //               // on double tap
  //               onDoubleTap: () {
  //                 Navigator.of(context).push(
  //                     // MaterialPageRoute(builder: (context) => LevelOne(),),
  //                     CustomPageRoute(
  //                   child: LevelOne(),
  //                 ));
  //               },
  //             ),
  //           ),
  //           Case(
  //             _selectedHoleIndex == index,
  //             // normalemnt not needed && h.status == HoleStatus.selected,
  //             builder: () => Image.asset("lib/assets/new_selected.png"),
  //           ),
  //         ],
  //         defaultBuilder: () => Container(),
  //       ),
  //     ),
  //   );
  // }
}
