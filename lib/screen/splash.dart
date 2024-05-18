import 'package:flutter/material.dart';
import 'package:kerjain/screen/onboard.dart';

class kerjaSplash extends StatefulWidget {
  const kerjaSplash({super.key});

  @override
  _KerjaSplashState createState() => _KerjaSplashState();
}

class _KerjaSplashState extends State<kerjaSplash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context, PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 3000), // Adjust the duration as needed
        pageBuilder: (_, __, ___) => Onboard(), // Onboard() is your destination widget
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset('assets/kerjain.png'),
      ),
    );
  }
}