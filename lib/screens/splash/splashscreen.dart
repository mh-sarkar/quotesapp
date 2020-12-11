import 'dart:async';

import 'package:demoapp/screens/pageone/pageone.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 2000,
      ),
    );
    _animationController.repeat(reverse: true);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });
    Timer(Duration(milliseconds: 5000), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => PageOneScreen(),
      ));
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Center(
        child: Container(
          child: ShaderMask(
            child: Text(
              "DEMO APP",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            shaderCallback: (rect) {
              return LinearGradient(
                stops: [
                  _animation.value - .5,
                  _animation.value,
                  _animation.value + .5
                ],
                colors: [
                  Colors.greenAccent,
                  Colors.yellow,
                  Colors.lightGreen,
                ],
              ).createShader(rect);
            },
          ),
        ),
      ),
    );
  }
}
