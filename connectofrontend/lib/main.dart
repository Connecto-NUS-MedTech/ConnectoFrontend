import 'dart:io';

import 'package:connectofrontend/screens/login.dart';
import 'package:connectofrontend/screens/main_dashboard/main_dashboard.dart';
import 'package:connectofrontend/screens/onboarding/onboarding.dart';
import 'package:connectofrontend/screens/screen_wrapper.dart';
import 'package:connectofrontend/screens/signup/otp.dart';
import 'package:connectofrontend/screens/signup/signup.dart';
import 'package:connectofrontend/screens/signup/signup2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: 'supabase.env');

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

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
            initialRoute: '/',
            routes: {
              '/': (context) => const OnboardingScreen(),
              '/login': (context) => const LoginScreen(),
              '/signup': (context) => const SignupScreen2(),
              '/dashboard': (context) => const MainDashboardScreen(),
            },
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
