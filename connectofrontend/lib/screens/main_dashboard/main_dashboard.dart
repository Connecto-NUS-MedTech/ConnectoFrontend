import 'package:flutter/material.dart';
import 'package:connectofrontend/widgets/master_card.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => MainDashboardScreenState();
}

class MainDashboardScreenState extends State<MainDashboardScreen> {
  final bool _allLights = false;
  final bool _allFans = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 32),
          child: Column(
            children: [
              // TODO: Replace Container with custom widget
              Container(
                height: 125,
                color: Colors.grey,
                child: const Row(
                  children: [
                    Text('ExternalApplications widget goes here'),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              // Home Environmental Conditions Control section
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Home Environmental Conditions Control',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MasterCard(
                            cardText: 'ALL LIGHTS',
                            cardState: _allLights,
                          ),
                        ),
                        const SizedBox(
                          width: 32,
                        ),
                        Expanded(
                          child: MasterCard(
                            cardText: 'ALL FANS',
                            cardState: _allFans,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              // TODO: Replace Container with custom widget
              Container(
                height: 400,
                color: Colors.grey,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      width: 300,
                      color: Colors.grey[600],
                      child: const Text(
                        'RoomEnvironmentConditionsTab widget goes here',
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Container(
                      width: 300,
                      color: Colors.grey[600],
                      child: const Text(
                        'Room Environment Conditions Tab widget goes here',
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Container(
                      width: 300,
                      color: Colors.grey[600],
                      child: const Text(
                        'Room Environment Conditions Tab widget goes here',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
