import 'dart:io';
import 'package:connectofrontend/screens/onboarding/onboarding.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://iuiwtlozrllebllvbqal.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml1aXd0bG96cmxsZWJsbHZicWFsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI0NTkwNjEsImV4cCI6MjAxODAzNTA2MX0.LsXfZ8gFvqOzz2szQ0Ld0t0fuJ8oXP6xyUSiDZAFB0M',
  );
  final supabase = Supabase.instance.client;
  runApp(MyApp(supabase: supabase));
}

// It's handy to then extract the Supabase client in a variable for later uses

class MyApp extends StatelessWidget {
  final SupabaseClient supabase;
  const MyApp({Key? key, required this.supabase}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? MaterialApp(
            title: 'Connecto',
            theme: ThemeData(
              primarySwatch: Colors.orange,
              scaffoldBackgroundColor: const Color(0xFFEFEFEF),
            ),
            home: OnboardingScreen(supabase: supabase),
          )
        : CupertinoApp(
            title: 'Connecto',
            theme: const CupertinoThemeData(
              primaryColor: CupertinoColors.activeOrange,
              scaffoldBackgroundColor: Color(0xFFEFEFEF),
            ),
            home: OnboardingScreen(supabase: supabase),
          );
  }
}
