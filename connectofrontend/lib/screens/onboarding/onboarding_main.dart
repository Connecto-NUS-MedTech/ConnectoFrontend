import 'package:flutter/material.dart';

class OnboardingMainScreen extends StatefulWidget {
  const OnboardingMainScreen({super.key});

  @override
  State<OnboardingMainScreen> createState() => _OnboardingMainScreenState();
}

class _OnboardingMainScreenState extends State<OnboardingMainScreen> {
  int _currPageIndex = 0;
  List<Column> _pageColumns = [];

  bool get _isFirstPage => _currPageIndex == 0;
  bool get _isLastPage => _currPageIndex == _pageColumns.length - 1;

  @override
  void initState() {
    super.initState();
    _pageColumns = [
      Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Onboarding',
              style: TextStyle(fontSize: 32),
            ),
          ),
          Image.asset(
            'assets/images/house_conditions_row.png',
            height: 250,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: const Center(
              child: Text(
                'Hello There!\nWelcome Aboard!',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 200,
            // width: MediaQuery.of(context).size.width * 0.65,
            width: 700,
            child: Center(
              child: Text(
                'Connecto was designed with the aim of allowing patients with Muscular Dystrophy to control their smart IoT home systems with ease!',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
      Column(
        children: [
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'SECOND PAGE',
              style: TextStyle(fontSize: 32),
            ),
          ),
          Image.asset(
            'assets/images/house_conditions_row.png',
            height: 250,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
            child: const Center(
              child: Text(
                'Hello There!\nWelcome Aboard!',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(
            height: 200,
            // width: MediaQuery.of(context).size.width * 0.65,
            width: 700,
            child: Center(
              child: Text(
                'Connecto was designed with the aim of allowing patients with Muscular Dystrophy to control their smart IoT home systems with ease!',
                style: TextStyle(fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Spacer(),
        ],
      )
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
                          label: const Text('Prev'),
                        )
                      : Container(),
                  !_isLastPage
                      ? ElevatedButton.icon(
                          onPressed: _handleNext,
                          icon: const Icon(Icons.arrow_forward),
                          label: const Text('Next'),
                        )
                      : Container(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
