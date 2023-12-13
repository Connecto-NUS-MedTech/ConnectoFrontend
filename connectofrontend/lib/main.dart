import 'dart:io';
import 'package:connectofrontend/screens/onboarding/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://iuiwtlozrllebllvbqal.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1aXd0bG96cmxsZWJsbHZicWFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI0NTkwNjEsImV4cCI6MjAxODAzNTA2MX0.LsXfZ8gFvqOzz2szQ0Ld0t0fuJ8oXP6xyUSiDZAFB0M',
  );

  final supabase = Supabase.instance.client;
  final response = await supabase.from('User_Table').upsert([
    {'Id': 85432644, 'Name': 'Test'},
  ]);

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
