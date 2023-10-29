import 'dart:io';

import 'package:connectofrontend/screens/onboarding/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialApp(
            title: 'Connecto',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              scaffoldBackgroundColor: const Color(0xFFEFEFEF),
            ),
            home: const OnboardingScreen(),
          )
        : const CupertinoApp(
            title: 'Connecto',
            theme: CupertinoThemeData(
              primaryColor: CupertinoColors.activeOrange,
              scaffoldBackgroundColor: Color(0xFFEFEFEF),
            ),
            home: OnboardingScreen(),
          );
  }
}
