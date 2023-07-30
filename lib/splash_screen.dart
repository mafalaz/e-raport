import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_crud/loginpage.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Set delay for displaying splash screen
    Timer(Duration(seconds: 5), () {
      // Navigate to login screen after delay
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });

    // Initialize animation controller and animation for text
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 24, end: 36).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Animated text "E-Raport SDN Kosambi"
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Text(
                  'E-Raport\nSDN 1 Kosambi',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: _animation.value,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
            SizedBox(height: 20),
            // Loading spinner
            SpinKitFadingCube(
              color: Colors.white,
              size: 50.0,
            ),
          ],
        ),
      ),
    );
  }
}
