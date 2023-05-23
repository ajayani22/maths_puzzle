import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maths_puzzle/GamePage.dart';
import 'package:maths_puzzle/LevelPage.dart';
import 'package:maths_puzzle/model.dart';

class ContinueLevelPage extends StatefulWidget {
  @override
  State<ContinueLevelPage> createState() => _ContinueLevelPageState();
}

class _ContinueLevelPageState extends State<ContinueLevelPage> {
  int currentLevel = 0;
  @override
  void initState() {
    super.initState();
    currentLevel = Model.pref!.getInt(Model.levelkey) ?? 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fitHeight,
            image: AssetImage('assets/background.jpg'),
          ),
        ),
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PuzzleGamePage(currentLevel),
                    ));
              },
              child: Text(
                'Continue',
                style: TextStyle(fontSize: 70, color: Colors.blueGrey),
              ),
            ),
            SizedBox(height: 40),
            Divider(
              color: Colors.grey,
              indent: 300,
              endIndent: 300,
            ),
            SizedBox(height: 40),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LevelPage()));
              },
              child: Text(
                'Level',
                style: TextStyle(fontSize: 70, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
