import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/home_system/custom_switch.dart';
import 'package:connectofrontend/widgets/home_system/home_system_rooms_tab.dart';
import 'package:flutter/material.dart';
import 'package:connectofrontend/widgets/home_system/master_card.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class AppInfo {
  final String name;
  final IconData icon;

  AppInfo({required this.name, required this.icon});
}

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
      id: 0,
      name: 'Hallway',
      devices: [
        LightDevice(id: 0, name: 'Light 1', brightness: 0.5),
        FanDevice(id: 0, name: 'Fan 1', speed: 0.8),
        FanDevice(id: 0, name: 'Fan 2', speed: 0.8),
      ],
    ),
    Room(
      id: 1,
      name: 'Kitchen',
      devices: [
        LightDevice(id: 0, name: 'Light 1', brightness: 0.5),
        LightDevice(id: 0, name: 'Light 2', brightness: 0.5),
      ],
    ),
    // FOR TESTING, DELETE LATER
    Room(
      id: 0,
      name: 'Test 1',
      devices: [
        LightDevice(id: 0, name: 'Light 1', brightness: 0.5),
        FanDevice(id: 0, name: 'Fan 2', speed: 0.8),
      ],
    ),
    Room(
      id: 0,
      name: 'Test 2',
      devices: [
        LightDevice(id: 0, name: 'Light 1', brightness: 0.5),
        LightDevice(id: 0, name: 'Light 2', brightness: 0.5),
      ],
    ),
  ];

  // when the main fan/light switch toggles, toggle all fan/light switches accordingly
  void toggleAllDevices(String cardText, SwitchStatus newStatus) {
    Device deviceType = cardText == 'ALL LIGHTS'
        ? LightDevice(id: 0, name: 'Test Light', brightness: 0.5)
        : FanDevice(id: 0, name: 'Test Fan', speed: 0.5);
    for (Room room in rooms) {
      for (Device dev in room.devices) {
        if (dev.runtimeType == deviceType.runtimeType) {
          setState(() {
            dev.isOn = newStatus != SwitchStatus.off;
          });
        }
      }
    }
  }

  Widget buildExternalApplications() {
    // Replace this with your actual list of apps
    List<AppInfo> externalApps = [
      AppInfo(name: 'Chrome', icon: Icons.apps),
      AppInfo(name: 'Instagram', icon: Icons.apps),
      AppInfo(name: 'Maps', icon: Icons.apps),
      AppInfo(name: 'Add App', icon: Icons.add),
      AppInfo(name: 'Add App', icon: Icons.add),

      // Add more apps as needed
    ];

    return Container(
      height: 125,
      color: Colors.grey,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: externalApps.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(
                    externalApps[index].icon,
                    size: 48, // Adjust the size of the icon
                  ),
                  onPressed: () async {
                    await LaunchApp.openApp(
                      androidPackageName: 'com.android.chrome',
                      openStore: false,
                    );
                    // Handle app button click
                    // You can navigate to the app or perform any other action
                  },
                ),
                const SizedBox(
                  height: 8, // Add spacing between the icon and text
                ),
                Text(
                  externalApps[index].name,
                  style: const TextStyle(
                    fontSize: 16, // Adjust the size of the text
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Replace the Container with custom widget
                buildExternalApplications(),
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: Row(
                        children: [
                          Expanded(
                            child: MasterCard(
                              cardText: 'ALL LIGHTS',
                              callback: toggleAllDevices,
                            ),
                          ),
                          const SizedBox(
                            width: 32,
                          ),
                          Expanded(
                            child: MasterCard(
                              cardText: 'ALL FANS',
                              callback: toggleAllDevices,
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
                HomeSystemRoomsTab(rooms: rooms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
