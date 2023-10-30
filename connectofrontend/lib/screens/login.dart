import 'package:flutter/material.dart';
import 'package:connectofrontend/screens/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
    bool _passwordVisible = false;

    void _togglePasswordVisibility() {
        setState(() {
            _passwordVisible = !_passwordVisible;
        });
    }


  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      resizeToAvoidBottomInset : false,
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
                  child: Text('Login Page', style: TextStyle(fontSize: 32),),
                ),
                // Padding(
                //   padding: EdgeInsets.only(right: 48, top: 48),
                //   child: Text('Sign up'),
                // )
              ]),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 56),
                        child: TextFormField(
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            suffixIcon: IconButton(
                                icon: Icon(
                                    _passwordVisible ? Icons.visibility : Icons.visibility_off,
                                ),
                                onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          obscureText: !_passwordVisible,
                          autocorrect: false,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFF9900),
                              minimumSize: Size(160, 48)
                              ),
                          child: const Text(
                            'Log In',
                            style: TextStyle(color: Color(0xFF212121), fontSize: 24)
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Row(
                            children: [
                            Expanded(
                                child: Divider(
                                    thickness: 2
                                )
                            ),
                            Text(" OR ", style: TextStyle(color: Color(0xFF7B7B7B))),
                            Expanded(
                                child: Divider(
                                    thickness: 2
                                )
                            ),
                        ]
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFFFFF),
                              minimumSize: Size(160, 48)
                            // minimumSize: const Size(double.infinity, double.infinity)

                              ),
                              child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Image.asset('assets/images/google_logo.png',
                            width: 32,
                            height: 32,),
                            SizedBox(width: 8), // Add some spacing between the image and text
                            Text(
                                'Google',
                                style: TextStyle(color: Color(0xFF212121), fontSize: 24)
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
                              Text(
                                'No account? Create one ',
                                style: TextStyle(
                                    color: Color(0xFF212121), fontSize: 16),
                              ),
                              GestureDetector(
                                onTap: () {
                            
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SignupScreen()),
                            );
                          },
                                child: const Text(
                                  'here',
                                  style: TextStyle(
                                      color: Color(0xFF44C7FF),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              ),
                            ],
                          )),
                    ]),
              ),
              const Expanded(flex: 1, child: Text('')),
            ],
          ))
        ],
      ),
      )
    );
  }
}
