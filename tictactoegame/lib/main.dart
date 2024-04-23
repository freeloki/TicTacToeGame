import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:tictactoegame/tictactoe.dart';
import 'package:get/get.dart';

void main() {
  runApp(const GetMaterialApp(home: MainApp()));
}

var globalState = GameState.init.obs;

var lockOtherCells = false.obs;

var isPlayed = false.obs;

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() {
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

var gameState = GameState.init.obs;

void clickedCb(id) {
  print('Cell ${id} clicked');
}

var ticTacToeGameWidget = TicTacToeGameWidget();
var btnText = "Start".obs;
var infoText = "Please click the start button to start the game".obs;

var clearState = false.obs;

class _MainAppState extends State<MainApp> {
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
                  if (globalState.value == GameState.xWin) {
                    infoText.value = "X wins";
                    gameState.value = GameState.xWin;
                    btnText.value = "Game Over";
                    clearState.value = true;
                    return;
                  } else if (globalState.value == GameState.oWin) {
                    infoText.value = "O wins";
                    gameState.value = GameState.oWin;
                    btnText.value = "Game Over";
                    clearState.value = true;
                    return;
                  } else if (globalState.value == GameState.draw) {
                    infoText.value = "Draw";
                    gameState.value = GameState.draw;
                    btnText.value = "Game Over";
                    clearState.value = true;
                    return;
                  } else if (globalState.value == GameState.init) {
                    infoText.value =
                        "Please click the start button to start the game";
                  }
                  if (GameState.init == gameState.value) {
                    gameState.value = GameState.xTurn;
                    infoText.value = xTurn;
                    btnText.value = "Confirm Move";
                    lockOtherCells.value = false;
                  }
                  if (isPlayed.value) {
                    if (GameState.xTurn == gameState.value) {
                      gameState.value = GameState.oTurn;
                      infoText.value = oTurn;
                      lockOtherCells.value = false;
                    } else if (GameState.oTurn == gameState.value) {
                      gameState.value = GameState.xTurn;
                      infoText.value = xTurn;
                      lockOtherCells.value = false;
                    }

                    isPlayed.value = false;
                  }
                  globalState = gameState;
                });
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.limeAccent)),
              child: Obx(
                () => Text(
                  btnText.string,
                  style: const TextStyle(fontSize: 16, color: Colors.black),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(2.0)),
            Obx(
              () => Visibility(
                visible: clearState.value,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.limeAccent)),
                  onPressed: () {
                    clearBoard();
                  },
                  child: const Text(
                    "Clear Board",
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(2.0)),
            Obx(
              () => Text(
                infoText.string,
                style: const TextStyle(fontSize: 16, color: Colors.blueAccent),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

void clearBoard() {
  cellItemWidgetList.clear();
  containerList.clear();
  btnText.value = "Start";
  infoText.value = "Please click the start button to start the game";
  globalState.value = GameState.init;
  lockOtherCells.value = false;
  isPlayed.value = false;
  ticTacToeGameWidget = TicTacToeGameWidget();
  clearState.value = false;
}
