// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'games.dart';

Games games = Games();

class Tic extends StatefulWidget {
  const Tic({Key? key}) : super(key: key);

  @override
  _TicState createState() => _TicState();
}

class _TicState extends State<Tic> {
  bool gameOver = false;
  String newValue = "X";
  String result = "";
  int number = 0;
  List<int> scoreFace = [0, 0, 0, 0, 0, 0, 0, 0];

  @override
  void initState() {
    games.face = Games.gameFace();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.amber,
        body: ListView(children: [
          SizedBox(
            height: 5,
          ),
          Align(
            alignment: Alignment.center,
            child: gameOver
                ? Text('  Agani',
                    style: TextStyle(
                      fontFamily: 'styleScript',
                      color: Colors.black,
                      fontSize: 45,
                    ))
                : Text(
                    " $newValue  ...اللعب علي",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 45,
                        fontWeight: FontWeight.bold),
                  ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            height: width,
            width: width,
            child: GridView.count(
                crossAxisCount: 3,
                padding: EdgeInsets.all(10),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                children: List.generate(
                    9,
                    (index) => ElevatedButton(
                        onPressed: gameOver
                            ? null
                            : () {
                                press(index);
                              },
                        child: Text(
                          games.face![index],
                          style: TextStyle(
                              color: games.face![index] == 'X'
                                  ? Colors.black
                                  : Colors.pink,
                              fontWeight: FontWeight.bold,
                              fontSize: 60),
                        )))),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Text(
                '     $result      ',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30.0),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton.icon(
              icon: Icon(
                Icons.replay,
                size: 30,
                color: Colors.black,
              ),
              label: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  "مــرة ثـانية",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 30.0),
                ),
              ),
              onPressed: () {
                setState(() {
                  games.face = Games.gameFace();
                  newValue = "X";
                  gameOver = false;
                  number = 0;
                  result = "";
                  scoreFace = [0, 0, 0, 0, 0, 0, 0, 0];
                });
              },
            ),
          ),
        ]));
  }

  press(int index) {
    if (games.face![index] == '') {
      setState(() {
        games.face![index] = newValue;
        number++;
        gameOver = games.winnerOrFailed(newValue, index, scoreFace, 3);
        if (gameOver) {
          voice('wow.mp3');
          result = '$newValue ...الفائز هو ';
        } else if (!gameOver && number == 9) {
          gameOver = true;
        }
        if (newValue == 'X') {
          newValue = 'O';
        } else {
          newValue = 'X';
        }
      });
    }
  }
}

voice(String audio) {
  final _play = AudioCache();
  _play.play(audio);
}

class Plays {
  static const x = 'X';
  static const o = 'O';
  static const z = '';
}
