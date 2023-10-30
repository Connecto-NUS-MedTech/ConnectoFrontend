import 'package:flutter/material.dart';
import 'package:connectofrontend/screens/signup.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currPageIndex = 0;
  List<Column> _pageColumns = [];

  bool get _isFirstPage => _currPageIndex == 0;
  bool get _isLastPage => _currPageIndex == _pageColumns.length - 1;

  @override
  void initState() {
    super.initState();

    const Align pageHeader = Align(
      alignment: Alignment.centerLeft,
      child: Text(
        'Onboarding Page',
        style: TextStyle(fontSize: 32),
      ),
    );

    _pageColumns = [
      // Page 1
      Column(
        children: [
          pageHeader,
          Image.asset(
            'assets/images/project_connecto_icon.png',
            height: 250,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: const Center(
              child: Text(
                'Hello There!\nWelcome Aboard!',
                style: TextStyle(fontSize: 32, color: Colors.orange),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 200,
            // width: MediaQuery.of(context).size.width * 0.65,
            width: 700,
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'Connecto  ',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.orange,
                  ),
                  // style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          'was designed with the aim of allowing patients with ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(text: 'Muscular Dystrophy '),
                    TextSpan(
                      text: 'to control their ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(text: 'smart IoT home systems '),
                    TextSpan(
                      text: 'with ease!',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
      // Page 2
      Column(
        children: [
          pageHeader,
          const Spacer(),
          Image.asset(
            'assets/images/house_conditions_row.png',
            height: 250,
          ),
          SizedBox(
            height: 200,
            // width: MediaQuery.of(context).size.width * 0.65,
            width: 700,
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'You can control all your ',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                  ),
                  // style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'house fan and lighting ',
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextSpan(
                      text:
                          'conditions with ease, all through the press of a button!',
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
      // Page 3
      Column(
        children: [
          pageHeader,
          Image.asset(
            'assets/images/external_apps_row.png',
            height: 250,
          ),
          SizedBox(
            height: 200,
            // width: MediaQuery.of(context).size.width * 0.65,
            width: 700,
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  text: 'You may select and ',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                  ),
                  // style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'access other applications ',
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextSpan(text: 'straight from '),
                    TextSpan(
                      text: 'Connecto',
                      style: TextStyle(color: Colors.orange),
                    ),
                    TextSpan(text: '!'),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    ];
  }

  void _handlePrev() {
    if (_currPageIndex == 0) return;
    setState(() {
      _currPageIndex--;
    });
  }

  void _handleNext() {
    if (_currPageIndex == _pageColumns.length - 1) return;
    setState(() {
      _currPageIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 32),
          child: Column(
            children: [
              ..._pageColumns[_currPageIndex].children,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  !_isFirstPage
                      ? ElevatedButton.icon(
                          onPressed: _handlePrev,
                          icon: const Icon(Icons.arrow_back),
                          label: const Text('Previous Page'),
                        )
                      : Container(),
                  !_isLastPage
                      ? ElevatedButton(
                          onPressed: _handleNext,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Next Page'),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        )
                      : ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignupScreen(),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sign Up!'),
                              Icon(Icons.arrow_forward),
                            ],
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
