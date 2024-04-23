import 'package:flutter/material.dart';
import 'package:tictactoegame/tictactoe.dart';

void main() {
  runApp(const MainApp());
}

var globalState = GameState.init;

var lockOtherCells = false;

var isPlayed = false;

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MainAppState();
  }
}

enum GameState {
  xTurn,
  oTurn,
  xWin,
  oWin,
  draw,
  init,
}

GameState gameState = GameState.init;

void clickedCb(id) {
  print('Cell ${id} clicked');
}

var ticTacToeGameWidget = TicTacToeGameWidget();

class _MainAppState extends State<MainApp> {
  String infoText = "Please click the start button to start the game";
  String btnText = "Start";
  String xTurn = "X's turn";
  String oTurn = "O's turn";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe Game'),
        ),
        body: Column(
          children: [
            Container(
                padding: const EdgeInsets.all(30.0),
                child: ticTacToeGameWidget),
            TextButton(
              onPressed: () {
                //change state
                print('Start button clicked $gameState');

                setState(() {
                  if (globalState == GameState.xWin) {
                    infoText = "X wins";
                    gameState = GameState.xWin;
                    btnText = "Game Over";
                    return;
                  } else if (globalState == GameState.oWin) {
                    infoText = "O wins";
                    gameState = GameState.oWin;
                    btnText = "Game Over";
                  } else if (globalState == GameState.draw) {
                    infoText = "Draw";
                    gameState = GameState.draw;
                    btnText = "Game Over";
                  } else if (globalState == GameState.init) {
                    infoText =
                        "Please click the start button to start the game";
                  }
                  if (GameState.init == gameState) {
                    gameState = GameState.xTurn;
                    infoText = xTurn;
                    btnText = "Accept Move";
                    lockOtherCells = false;
                  }
                  if (isPlayed) {
                    if (GameState.xTurn == gameState) {
                      gameState = GameState.oTurn;
                      infoText = oTurn;
                      lockOtherCells = false;
                    } else if (GameState.oTurn == gameState) {
                      gameState = GameState.xTurn;
                      infoText = xTurn;
                      lockOtherCells = false;
                    }

                    isPlayed = false;
                  }
                  globalState = gameState;
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.limeAccent)),
              child: Text(
                btnText,
                style: const TextStyle(fontSize: 24, color: Colors.black),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10.0)),
            Text(
              infoText,
              style: const TextStyle(fontSize: 24, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
