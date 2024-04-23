// create a tictactoe grid with 3x3 cells
// Path: lib/tictactoe.dart
import 'package:flutter/material.dart';
import 'main.dart';

void onGridItemClick(widget) {
  print('Cell ${widget.id} clicked');
}

List<List> winnerList = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6]
];
var containerList = [];
var cellItemWidgetList = [];

class TicTacToeGameWidget extends StatefulWidget {
  TicTacToeGameWidget({super.key});

  @override
  State<StatefulWidget> createState() {
    return TicTacToeGameWidgetState();
  }
}

List<Widget> createGridItems() {
  List<Container> containers = [];
  cellItemWidgetList = [];
  for (var i = 0; i < 9; i++) {
    var cellItem = CellItemWidget(id: i, value: "", playable: true);
    containers.add(Container(child: cellItem));
    cellItemWidgetList.add(CellItemWidget(id: i, value: "", playable: true));
  }
  return containers;
}

//create state class
class TicTacToeGameWidgetState extends State<TicTacToeGameWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      // center vertical and horizontal
      shrinkWrap: true,
      crossAxisCount: 3,
      children: containerList = createGridItems(),
    );
  }
}

void onPressedTry() {}

class CellItemWidget extends StatefulWidget {
  int id;
  String value = "";
  bool playable;
  Color color = Colors.blue;
  Color xColor = Colors.tealAccent;
  Color oColor = const Color.fromARGB(255, 93, 64, 255);

  CellItemWidget(
      {super.key,
      required this.id,
      required this.value,
      required this.playable});

  @override
  State<StatefulWidget> createState() {
    return CellItemWidgetState();
  }
}

class CellItemWidgetState extends State<CellItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      color: widget.color,
      width: 100.0,
      height: 100.0,
      child: Center(
          child: TextButton(
              onPressed: () => {
                    onGridItemClick(widget),
                    setState(() {
                      print(
                          "lockothercells $lockOtherCells, isplayed $isPlayed, widget.playable ${widget.playable} ");
                      if (!lockOtherCells) {
                        if (widget.playable && !isPlayed) {
                          lockOtherCells = true;
                          if (globalState == GameState.xTurn) {
                            widget.value = 'X';
                            widget.playable = false;
                            widget.color = widget.xColor;
                            isPlayed = true;
                          } else if (globalState == GameState.oTurn) {
                            widget.value = 'O';
                            widget.playable = false;
                            widget.color = widget.oColor;
                            isPlayed = true;
                          }
                        }
                        // update cellItemWidgetList
                        cellItemWidgetList[widget.id].value = widget.value;
                        cellItemWidgetList[widget.id].playable =
                            widget.playable;
                        cellItemWidgetList[widget.id].color = widget.color;
                      }

                      //check if the game is over
                      for (var i = 0; i < winnerList.length; i++) {
                        //print("winnerList ${winnerList[i][0]} ");
                        if (cellItemWidgetList[winnerList[i][0]].value == 'X' &&
                            cellItemWidgetList[winnerList[i][1]].value == 'X' &&
                            cellItemWidgetList[winnerList[i][2]].value == 'X') {
                          globalState = GameState.xWin;
                          print("X wins setting global state");
                          return;
                        } else if (cellItemWidgetList[winnerList[i][0]].value ==
                                'O' &&
                            cellItemWidgetList[winnerList[i][1]].value == 'O' &&
                            cellItemWidgetList[winnerList[i][2]].value == 'O') {
                          globalState = GameState.oWin;
                          print(" O wins setting global state");
                          return;
                        }
                      }
                      bool emptyCell = false;
                      print("Length is : ${cellItemWidgetList.length}");
                      for (int i = 0; i < cellItemWidgetList.length; i++) {
                        print("Data is : ${cellItemWidgetList[i].value}");

                        if (cellItemWidgetList[i].value == "") {
                          emptyCell = true;
                        }
                      }
                      if (!emptyCell) {
                        globalState = GameState.draw;
                        print("Setting global state to draw");
                      }
                    }),
                  },
              child: Text(
                widget.value,
                style: const TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ))),
    );
  }
}
