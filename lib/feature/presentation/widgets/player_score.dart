import 'package:flutter/material.dart';

class player_score extends StatefulWidget {
  player_score(
      {super.key, required this.text, required this.score, required this.isX});
  String text;
  String score;
  bool isX;

  @override
  State<player_score> createState() => _player_scoreState();
}

class _player_scoreState extends State<player_score> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.deepPurple, width: 1),
      ),
      child: Column(
        children: [
          Text(widget.text,
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'first',
                color: widget.isX ? Colors.deepPurple : Colors.purple,
              )),
          Text('score',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'first',
                color: widget.isX ? Colors.deepPurple : Colors.purple,
              )),
          Text(widget.score,
              style: TextStyle(
                fontSize: 30,
                fontFamily: 'second',
                color: widget.isX ? Colors.deepPurple : Colors.purple,
              )),
        ],
      ),
    );
  }
}