import 'package:flutter/material.dart';
import 'package:maths_puzzle/ContinueLevelPage.dart';
import 'package:maths_puzzle/GamePage.dart';
import 'package:maths_puzzle/model.dart';

class LevelPage extends StatefulWidget {
  @override
  State<LevelPage> createState() => _LevelPageState();
}

class _LevelPageState extends State<LevelPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'), fit: BoxFit.fill),
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Text(
              'Select Puzzle',
              style: TextStyle(
                fontSize: 40,
                fontFamily: 'DroidSerif',
                color: Color(0xff383bb7),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: GridView.builder(
                    itemCount: Model.answers.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 12,
                        childAspectRatio: 1.20,
                        mainAxisSpacing: 12,
                        crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      int currLevel = Model.pref?.getInt(Model.levelkey) ?? 0;

                      String status = Model.pref!.getString("status$index") ??
                          Model.pending;

                      if (status == Model.clear) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PuzzleGamePage(index),
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/tick.png')),
                                border: Border.all(color: Color(0xffc8c722)),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 35,
                                fontFamily: 'DroidSerif',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      } else if (status == Model.skip || index == currLevel) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PuzzleGamePage(index),
                                ));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xffffa500)),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 35,
                                fontFamily: 'DroidSerif',
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Container(
                            alignment: Alignment.center,
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xff000000)),
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.transparent),
                            child: Image.asset('assets/lock.png'));
                      }
                    }),
              ),
            ),
            // SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () async {
                    await Model.pref!.clear();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ContinueLevelPage(),
                        ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 25),
                    height: 80,
                    width: 80,
                    child: Image.asset('assets/next.png', fit: BoxFit.fill),
                  ),
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
