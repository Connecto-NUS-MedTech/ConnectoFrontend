import 'package:connectofrontend/screens/main_dashboard/main_dashboard.dart';
import 'package:connectofrontend/screens/screen_wrapper.dart';
import 'package:connectofrontend/screens/signup/signup2.dart';
import 'package:connectofrontend/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OTPScreen extends StatefulWidget {
  final String email;
  const OTPScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<OTPScreen> createState() {
    return _OTPScreen();
  }
}

class _OTPScreen extends State<OTPScreen> {
  // TODO: shift focus to previous textfield when delete is pressed
  /// Verify the OTP entered by the user and return true if the OTP is valid,
  Future<bool> _verifyOTP() async {
    try {
      // OTP verification logic
      await supabase.auth.verifyOTP(
        email: widget.email,
        token: _otpEntered,
        type: OtpType.email,
      );
      return true; // On success
    } catch (error) {
      return false; // On failure
    }
  }

  String _otpEntered = '';

  void updateOTP(String digit) {
    setState(() {
      if (digit.isEmpty && _otpEntered.isNotEmpty) {
        // Remove the last character
        _otpEntered = _otpEntered.substring(0, _otpEntered.length - 1);
      } else if (_otpEntered.length < 6) {
        // Append new digit
        _otpEntered += digit;
      }
    });
  }

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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 48, top: 80),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupScreen2(),
                        ),
                      );
                    },
                    child: const Row(
                      children: [
                        Icon(Icons.arrow_back),
                        Text('Back'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 48, top: 16),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 32),
                  ),
                ),
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 56),
                          child: Form(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  height: 64,
                                  width: 64,
                                  child: TextFormField(
                                    autofocus: true,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        updateOTP(value);
                                        FocusScope.of(context)
                                            .nextFocus(); // Move to next field
                                      } else if (value.isEmpty) {
                                        updateOTP(''); // Delete last digit
                                        FocusScope.of(context)
                                            .previousFocus(); // Move to previous field
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 64,
                                  width: 64,
                                  child: TextFormField(
                                    autofocus: true,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        updateOTP(value);
                                        FocusScope.of(context)
                                            .nextFocus(); // Move to next field
                                      } else if (value.isEmpty) {
                                        updateOTP(''); // Delete last digit
                                        FocusScope.of(context)
                                            .previousFocus(); // Move to previous field
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 64,
                                  width: 64,
                                  child: TextFormField(
                                    autofocus: true,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        updateOTP(value);
                                        FocusScope.of(context)
                                            .nextFocus(); // Move to next field
                                      } else if (value.isEmpty) {
                                        updateOTP(''); // Delete last digit
                                        FocusScope.of(context)
                                            .previousFocus(); // Move to previous field
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 64,
                                  width: 64,
                                  child: TextFormField(
                                    autofocus: true,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        updateOTP(value);
                                        FocusScope.of(context)
                                            .nextFocus(); // Move to next field
                                      } else if (value.isEmpty) {
                                        updateOTP(''); // Delete last digit
                                        FocusScope.of(context)
                                            .previousFocus(); // Move to previous field
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 64,
                                  width: 64,
                                  child: TextFormField(
                                    autofocus: true,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        updateOTP(value);
                                        FocusScope.of(context)
                                            .nextFocus(); // Move to next field
                                      } else if (value.isEmpty) {
                                        updateOTP(''); // Delete last digit
                                        FocusScope.of(context)
                                            .previousFocus(); // Move to previous field
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 64,
                                  width: 64,
                                  child: TextFormField(
                                    autofocus: true,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.digitsOnly,
                                    ],
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        updateOTP(value);
                                        FocusScope.of(context)
                                            .nextFocus(); // Move to next field
                                      } else if (value.isEmpty) {
                                        updateOTP(''); // Delete last digit
                                        FocusScope.of(context)
                                            .previousFocus(); // Move to previous field
                                      }
                                    },
                                    keyboardType: TextInputType.number,
                                    maxLength: 1,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(200),
                                      ),
                                    ),
                                    textAlign: TextAlign.center,
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
                                'Did not receive OTP? ',
                                style: TextStyle(
                                  color: Color(0xFF212121),
                                  fontSize: 16,
                                ),
                              ),
                              GestureDetector(
                                // TODO: Trigger resend OTP
                                onTap: () {},
                                child: const Text(
                                  'Send OTP',
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
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: ElevatedButton(
                            // TODO: onPressed to allow account creation
                            onPressed: () async {
                              if (await _verifyOTP()) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const MainDashboardScreen(),
                                  ),
                                );
                              } else {
                                // Handle the case where OTP verification fails
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'OTP Verification failed. Please try again.',
                                    ),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF9900),
                              minimumSize: const Size(160, 48),
                            ),
                            child: const Text(
                              'Create Account',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                        // space at the bottom of the screen
                        const Padding(
                          padding: EdgeInsets.only(top: 32),
                          child: Text(''),
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
