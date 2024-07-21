

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:x_o_game_play/feature/presentation/widgets/player_score.dart';

class PcBody extends StatefulWidget {
  const PcBody({super.key});

  @override
  State<PcBody> createState() => _PcBodyState();
}

class _PcBodyState extends State<PcBody> {
  List xo = ["", "", "", "", "", "", "", "", ""];
  String firstClick = 'X';
  bool isX = true;
  int xScore = 0;
  int oScore = 0;
  int drawScore = 0;
  String winPlayer = "";
  bool isPlaying = true;
  Timer? timer;

  getWinner() {
    List winIndex = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];
    for (var i = 0; i < winIndex.length; i++) {
      String a = xo[winIndex[i][0]];
      String b = xo[winIndex[i][1]];
      String c = xo[winIndex[i][2]];
      if (a == b && b == c && a == c && a != "") {
        return a;
      }
    }
    if (!xo.contains("")) {
      return "Draw";
    }
    return "";
  }

  pcPlay() {
    List winIndex = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ];
    // win O
    for (var i = 0; i < winIndex.length; i++) {
      String a = xo[winIndex[i][0]];
      String b = xo[winIndex[i][1]];
      String c = xo[winIndex[i][2]];
      if (a == b && a == 'O' && c == '') {
        xo[winIndex[i][2]] = 'O';
        return;
      }
      if (a == c && a == 'O' && b == '') {
        xo[winIndex[i][1]] = 'O';
        return;
      }
      if (c == b && b == 'O' && a == '') {
        xo[winIndex[i][0]] = 'O';
        return;
      }
    }
    // win O

    // defeat X
    for (var i = 0; i < winIndex.length; i++) {
      String a = xo[winIndex[i][0]];
      String b = xo[winIndex[i][1]];
      String c = xo[winIndex[i][2]];
      if (a == b && a == 'X' && c == '') {
        xo[winIndex[i][2]] = 'O';
        return;
      }
      if (a == c && a == 'X' && b == '') {
        xo[winIndex[i][1]] = 'O';
        return;
      }
      if (c == b && b == 'X' && a == '') {
        xo[winIndex[i][0]] = 'O';
        return;
      }
    }
    // defeat X

    // paly any way
    List indxes = [0, 1, 2, 3, 4, 5, 7, 8]; // index of sq
    indxes.shuffle(Random());
    for (var i = 0; i < xo.length; i++) {
      if (xo[indxes[i]] == "") {
        xo[indxes[i]] = 'O';
        return;
      }
    }
    // paly any way
  }

    clearBoard() {
      for (int i = 0; i < xo.length; i++) {
        xo[i] = "";
      }
    }



    clearDuration(bool pcStart) {
      setState(() {
        isPlaying = false;
      });
      timer = Timer.periodic(Duration(seconds: 2), (timer) {
        clearBoard();
        timer?.cancel();
        isPlaying = true;
        setState(() {});
      });
      if(pcStart){
        pcPlay();
      }
    }


    @override
    Widget build(BuildContext context) {
      return Container(
        height: MediaQuery
            .of(context)
            .size
            .height,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Color(0xffAD39C0FF),
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 40,
                        )),
                    Text('Vs Pc',
                        style: TextStyle(
                          fontSize: 40,
                          fontFamily: 'first',
                        )),
                    IconButton(
                        onPressed: () {
                          clearBoard();
                          xScore = 0;
                          oScore = 0;
                          firstClick = "X";
                          setState(() {});
                        },
                        icon: Icon(
                          Icons.restart_alt,
                          size: 40,
                          color: Colors.white,
                        )),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    player_score(
                      text: 'x',
                      score: xScore.toString(),
                      isX: true,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 60,
                      width: 130,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.deepPurple)),
                      child: Center(
                          child: Text('Draw:${drawScore}',
                              style: const TextStyle(
                                  fontSize: 17,
                                  fontFamily: 'second',
                                  fontWeight: FontWeight.bold))),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    player_score(
                      text: 'o',
                      score: oScore.toString(),
                      isX: false,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Text('Now is Time for ${firstClick}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: 'second',
                    )),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SizedBox(
                    height: 450,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) =>
                          GestureDetector(
                            onTap: () {
                              if (xo[index] == '' && isPlaying == true) {
                                  xo[index] = 'X';
                                  isX = false;
                                  winPlayer = getWinner();
                                  if (winPlayer == 'X') {
                                    xScore++;
                                    firstClick = 'X';
                                    clearDuration(false);
                                  } else if (winPlayer == 'O') {
                                    oScore++;
                                    firstClick = 'O';
                                    clearDuration(true);
                                  }
                                  else if (winPlayer == "Draw") {
                                    drawScore++;
                                    clearDuration(false);
                                  }
                                  else {
                                     pcPlay();
                                    winPlayer = getWinner();
                                    if (winPlayer == 'O') {
                                      oScore++;
                                      clearDuration(true);
                                    }
                                    else if (winPlayer == "Draw") {
                                      drawScore++;
                                      clearDuration(true);
                                    }


                                  }
                                  setState(() {});
                                }
                            },
                            child: Container(
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(20),
                                border:
                                Border.all(color: Colors.deepPurple, width: 3),
                              ),
                              child: Center(
                                  child: Text(
                                    xo[index],
                                    style: TextStyle(
                                        fontSize: 80,
                                        fontFamily: 'first',
                                        color: isX ? Colors.purple : Colors
                                            .deepPurple),
                                  )),
                            ),
                          ),
                      itemCount: xo.length,
                    ),
                  ),
                )
              ],
            ),
            if (isPlaying == false)
              Positioned(
                bottom: MediaQuery
                    .of(context)
                    .size
                    .height / 2,
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 100,
                  color: getWinner() == 'X'
                      ? Colors.deepPurple
                      : getWinner() == 'O'
                      ? Colors.purple
                      : Colors.purpleAccent,
                  child: Center(
                      child: Text(
                          getWinner() == "Draw"
                              ? 'Draw'
                              : '${getWinner()} IS Win',
                          style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'first',
                              color: Colors.black))),
                ),
              ),
          ],
        ),
      );
    }
  }





