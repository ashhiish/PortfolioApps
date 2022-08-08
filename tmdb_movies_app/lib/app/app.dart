import 'package:flutter/material.dart';

import '../utils/gradients_manager.dart';

class MyApp extends StatefulWidget {
  // private constructor
  MyApp._internal();
  static final MyApp instance = MyApp._internal(); // single instance -- singleton

  // everytime I create an instance of this class then this specfic instance will be utilised instead of creating a
  // new instance everytime
  factory MyApp() => instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
                gradient: GradientsManager.universalGradient, borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Center(
              child: Text(
                "hehe",
                style: TextStyle(color: Colors.white),
                textScaleFactor: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
