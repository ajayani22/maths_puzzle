import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:maths_puzzle/ContinueLevelPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashwait();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Lottie.network(
            'https://assets7.lottiefiles.com/packages/lf20_loGwzbI7N3.json'),
      ),
    );
  }

  void splashwait() async {
    await Future.delayed(Duration(seconds: 1));
    Model.pref = await SharedPreferences.getInstance();
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ContinueLevelPage(),
        ));
  }
}
