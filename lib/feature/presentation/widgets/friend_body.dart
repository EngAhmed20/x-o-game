import 'dart:async';

import 'package:flutter/material.dart';
import 'package:x_o_game_play/feature/presentation/widgets/player_score.dart';

class FirendBody extends StatefulWidget {
  const FirendBody({super.key});

  @override
  State<FirendBody> createState() => _FirendBodyState();
}

class _FirendBodyState extends State<FirendBody> {
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

  clearBoard() {
    for (int i = 0; i < xo.length; i++) {
      xo[i] = "";
    }
  }

  clearDuration() {
    setState(() {
      isPlaying = false;
    });
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      clearBoard();
      timer?.cancel();
      isPlaying = true;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Color(0xffAD39C0FF),
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Text('Vs Friend',
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
                 const  SizedBox(
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
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        if (xo[index] == '' && isPlaying == true) {
                          if (firstClick == 'X') {
                            xo[index] = 'X';
                            isX = false;
                            winPlayer = getWinner();
                            if (winPlayer == 'X') {
                              xScore++;
                              firstClick = 'X';
                              clearDuration();

                              print("x ${xScore}");
                            } else if (winPlayer == 'O') {
                              oScore++;
                              firstClick = 'O';
                              clearDuration();
                            }
                            else if (winPlayer == "Draw") {
                              drawScore++;
                              clearDuration();
                            } else {
                              firstClick = 'O';
                            }
                            setState(() {});
                          } else {
                            xo[index] = 'O';
                            isX = true;
                            winPlayer = getWinner();
                            if (winPlayer == 'O') {
                              oScore++;
                              firstClick = 'O';
                              clearDuration();
                            } else if (winPlayer == 'X') {
                              xScore++;
                              firstClick = 'X';
                              clearDuration();
                            } else if (winPlayer == "Draw") {
                              drawScore++;
                              clearDuration();
                            } else {
                              firstClick = 'X';
                            }
                            setState(() {});
                          }
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
                              color: isX ? Colors.purple : Colors.deepPurple),
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
              bottom: MediaQuery.of(context).size.height / 2,
              child: Container(
                width: MediaQuery.of(context).size.width,
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


