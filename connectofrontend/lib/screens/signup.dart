import 'package:flutter/material.dart';
import 'package:connectofrontend/screens/login.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 48, top: 80),
                  child: Text(
                    'Sign Up Page',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(right: 48, top: 48),
                //   child: Text('Sign up'),
                // )
              ],
            ),
            Flexible(
              fit: FlexFit.loose,
              child: Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(''),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset('assets/images/project_connecto_icon.png'),
                        const Padding(
                          padding: EdgeInsets.only(top: 56),
                          child: Text(
                            'Sign up with: ',
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF9900),
                              minimumSize: const Size(160, 48),
                            ),
                            child: const Text(
                              'Email address',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFFFFF),
                              minimumSize: const Size(160, 48),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/images/google_logo.png',
                                  width: 32,
                                  height: 32,
                                ),
                                const SizedBox(
                                  width: 8,
                                ), // Add some spacing between the image and text
                                const Text(
                                  'Google',
                                  style: TextStyle(
                                    color: Color(0xFF212121),
                                    fontSize: 24,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                'Already have an account? Log in ',
                                style: TextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 16,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'here',
                                  style: TextStyle(
                                    color: Color(0xFF44C7FF),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Expanded(flex: 1, child: Text('')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
