import 'package:flutter/material.dart';
import 'package:tmdb_movies_app/utils/assets_manager.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFe8e3e3),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Image.asset(AppAssets.splashIcon),
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
    );
  }
}
