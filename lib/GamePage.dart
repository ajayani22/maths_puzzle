import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maths_puzzle/model.dart';

class PuzzleGamePage extends StatefulWidget {
  int currLevel = 0;

  PuzzleGamePage(this.currLevel);

  @override
  State<PuzzleGamePage> createState() => _PuzzleGamePageState();
}

class _PuzzleGamePageState extends State<PuzzleGamePage> {
  String ansFieldValue = '';
  int currLevel = 0;

  @override
  void initState() {
    super.initState();
    currLevel = widget.currLevel;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/gameplaybackground.jpg'),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: 11,
                ),
                alignment: Alignment.center,
                height: 65,
                width: 270,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/level_board.png'),
                  ),
                ),
                child: Text(
                  'Puzzle ${currLevel + 1}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'DroidSerif',
                      fontSize: 45),
                ),
              ),
              Expanded(
                child: Container(
                  height: 370,
                  width: double.infinity,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Image.asset(
                      'assets/${Model.imageLevel[currLevel]}',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 25),
                    alignment: Alignment.center,
                    child: IconButton(
                      onPressed: () async {
                        String status =
                            Model.pref!.getString('status${currLevel}') ??
                                Model.pending;

                        if (status != Model.clear) {
                          Model.pref!
                              .setString("status${currLevel}", Model.skip);
                          int level = ++currLevel;
                          await Model.pref!.setInt(Model.levelkey, level);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PuzzleGamePage(level),
                              ));
                        } else {
                          int level = Model.pref!.getInt(Model.levelkey) ?? 0;
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PuzzleGamePage(level),
                              ));
                        }
                      },
                      icon: Icon(
                        Icons.skip_next_rounded,
                        size: 55,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                alignment: Alignment.center,
                height: 120,
                width: MediaQuery.of(context).size.width,
                color: Colors.black,
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              width: 220,
                              height: 45,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Text(
                                '${ansFieldValue}',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              setState(() {
                                if (ansFieldValue.isNotEmpty) {
                                  ansFieldValue = ansFieldValue.substring(
                                      0, ansFieldValue.length - 1);
                                }
                              });
                            },
                            child: Container(
                              height: 45,
                              width: 45,
                              child: Image.asset(
                                'assets/delete.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              String rightans = Model.answers[currLevel];
                              int level = 0;

                              if (ansFieldValue == rightans) {
                                String status = Model.pref!
                                        .getString('status${currLevel}') ??
                                    Model.pending;

                                if (status == Model.pending) {
                                  level = currLevel + 1;
                                  await Model.pref!
                                      .setInt(Model.levelkey, level);
                                } else {
                                  level =
                                      Model.pref!.getInt(Model.levelkey) ?? 0;
                                }

                                Model.pref!.setString(
                                    "status${currLevel}", Model.clear);

                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          PuzzleGamePage(level),
                                    ));
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    actions: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    Colors.black),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('ok'))
                                    ],
                                    title: Text('Wrong Answer! Plz try again'),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'SUBMIT',
                              style: TextStyle(
                                  fontFamily: 'DroidSerif',
                                  fontSize: 20,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: numericButtons(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> numericButtons() {
    List<Widget> mylist = [];
    for (int i = 0; i < 10; i++) {
      mylist.add(
        Expanded(
          child: InkWell(
            onTap: () {
              setState(() {
                if (!ansFieldValue.startsWith('0')) {
                  ansFieldValue = '$ansFieldValue$i';
                }
              });
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  color: Color(0xff333333),
                  border: Border.all(color: Color(0xff868686))),
              alignment: Alignment.center,
              height: 45,
              width: 40,
              child: Text(
                '$i',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        ),
      );
    }
    return mylist;
  }
}
