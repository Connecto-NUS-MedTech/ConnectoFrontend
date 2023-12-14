import 'package:flutter/material.dart';
import 'package:connectofrontend/screens/signup/signup2.dart';
import 'package:flutter/services.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() {
    return _OTPScreen();
  }
}

class _OTPScreen extends State<OTPScreen> {
  // TO DO: shift focus to previous textfield when delete is pressed
  // bool correctOTP = false;
  bool checkCorrectOTP() {
    // TO DO: disable button if wrong OTP, enable if correct OTP
    if (_otpEntered.length == 4 && int.tryParse(_otpEntered) != null) {
      return true;
    }
    return false;
  }

  // TO DO: put the OTP together from the 4 textformfields
  String _otpEntered = 'aaaa';

  // might wanna condense the deletion handling but also how to detect keyboard backspace
  void updateOTP(digit, i) {
    setState(
      () {
        _otpEntered = _otpEntered.substring(0, i) +
            digit +
            _otpEntered.substring(i + 1, _otpEntered.length);
      },
    );
    print(_otpEntered);
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
                                    onSaved: (pin1) {},
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                        updateOTP(value, 0);
                                      } else if (value.isEmpty) {
                                        updateOTP('a', 0);
                                      }
                                      // else if (value.isEmpty && )
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
                                    // style:
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
                                    onSaved: (pin2) {},
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                        updateOTP(value, 1);
                                      } else if (value.isEmpty) {
                                        updateOTP('a', 1);
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
                                    // style:
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
                                    onSaved: (pin3) {},
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                        updateOTP(value, 2);
                                      } else if (value.isEmpty) {
                                        updateOTP('a', 2);
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
                                    // style:
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
                                    onSaved: (pin4) {},
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        FocusScope.of(context).nextFocus();
                                        updateOTP(value, 3);
                                      } else if (value.isEmpty) {
                                        updateOTP('a', 3);
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
                                    // style:
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
                                // TO DO: Trigger resend OTP
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
                            // TO DO: onPressed to allow account creation
                            onPressed: !checkCorrectOTP() ? null : () {},
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
