import 'package:expences_tracker/home/mainPage.dart';
import 'package:expences_tracker/register/register.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(child: Lottie.asset("assets/image/loadingHand.json")),
    );
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    if (prefs.containsKey('income')) {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => mainPage()),
            ModalRoute.withName('/home'));
      });
    } else {
      Future.delayed(Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => Register()),
            ModalRoute.withName('/home'));
      });
    }
  }
}
