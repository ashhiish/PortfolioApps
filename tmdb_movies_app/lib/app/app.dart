// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tmdb_movies_app/ui/onboarding/user_onboarding.dart';
import 'package:tmdb_movies_app/ui/splash/splash_screen.dart';

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
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      home: isInitializationDone
          ?
          // isUserFirstTime ? OnBoardingPage() : HomePage()
          OnBoardingPage()
          : SplashScreen(),
    );
  }
}
