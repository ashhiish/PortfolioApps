// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:tmdb_movies_app/ui/homepage/homepage.dart';

// theming
// routing
// sharedPreferences Logic and stuff

class MyApp extends StatefulWidget {
  // private constructor
  const MyApp._internal();
  static const MyApp instance = MyApp._internal(); // single instance -- singleton

  // everytime I create an instance of this class then this specfic instance will be utilised instead of creating a
  // new instance everytime
  factory MyApp() => instance;

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isInitializationDone = false;

  void initialize() async {
    /// here we will add a wait second to move on next screen
    /// in ideal scenario we will do stuff like initializing or other things
    Future.delayed(Duration(seconds: 3), () {
      /// after all the initialization is done
      /// then we will redirect user to homePage

      print("haha its working ");
      setState(() {
        isInitializationDone = true;
      });
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: isInitializationDone
          ? HomePage()
          : Scaffold(
              backgroundColor: Color(0xFFe8e3e3),
              body: SafeArea(
                child: Stack(
                  children: [
                    Center(
                      child: Image.asset("assets/images/splash/splash_icon.png"),
                    ),
                    Positioned(
                      bottom: 30,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: 400,
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
