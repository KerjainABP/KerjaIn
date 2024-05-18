import 'package:flutter/material.dart';
import 'package:kerjain/screen/splash.dart';

void main() {
  runApp(const kerjaIn());
}

class kerjaIn extends StatelessWidget {
  const kerjaIn({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KerjaIn',
      theme: ThemeData(

      ),
      debugShowCheckedModeBanner: false,
      home: const kerjaSplash(),
    );
  }
}

