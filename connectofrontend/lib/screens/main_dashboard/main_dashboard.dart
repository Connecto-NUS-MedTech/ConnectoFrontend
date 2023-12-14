import 'package:flutter/material.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => MainDashboardScreenState();
}

class MainDashboardScreenState extends State<MainDashboardScreen> {
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
              // TODO: Replace Container with custom widget
              Container(
                height: 100,
                color: Colors.grey,
                child: const Row(
                  children: [
                    Text('All Lights & All Fans widgets goes here'),
                  ],
                ),
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
