import 'package:connectofrontend/models/device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/home_system_rooms_tab.dart';
import 'package:flutter/material.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => MainDashboardScreenState();
}

class MainDashboardScreenState extends State<MainDashboardScreen> {
  // Hardcoded for now -- fetch from DB or local storage in the future
  List<Device> devices = [];
  List<Room> rooms = [
    Room(
      name: 'Hallway',
      devices: [
        LightDevice('Light 1', 0.5),
        FanDevice('Fan 1', 0.8),
        FanDevice('Fan 2', 0.8),
      ],
    ),
    Room(
      name: 'Kitchen',
      devices: [
        LightDevice('Light 1', 0.5),
        LightDevice('Light 2', 0.5),
      ],
    ),
  ];

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
              SizedBox(
                height: 400,
                child: HomeSystemRoomsTab(rooms: rooms),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
