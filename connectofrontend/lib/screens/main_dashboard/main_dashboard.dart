import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/custom_switch.dart';
import 'package:connectofrontend/widgets/home_system_rooms_tab.dart';
import 'package:flutter/material.dart';
import 'package:connectofrontend/widgets/master_card.dart';

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
        LightDevice(name: 'Light 1', brightness: 0.5),
        FanDevice(name: 'Fan 1', speed: 0.8),
        FanDevice(name: 'Fan 2', speed: 0.8),
      ],
    ),
    Room(
      name: 'Kitchen',
      devices: [
        LightDevice(name: 'Light 1', brightness: 0.5),
        LightDevice(name: 'Light 2', brightness: 0.5),
      ],
    ),
    // FOR TESTING, DELETE LATER
    Room(
      name: 'Test 1',
      devices: [
        LightDevice(name: 'Light 1', brightness: 0.5),
        FanDevice(name: 'Fan 2', speed: 0.8),
      ],
    ),
    Room(
      name: 'Test 2',
      devices: [
        LightDevice(name: 'Light 1', brightness: 0.5),
        LightDevice(name: 'Light 2', brightness: 0.5),
      ],
    ),
  ];

  // when the main fan/light switch toggles, toggle all fan/light switches accordingly
  void toggleAllDevices(String cardText, SwitchStatus newStatus) {
    Device deviceType = cardText == 'ALL LIGHTS'
        ? LightDevice(name: 'Test Light', brightness: 0.5)
        : FanDevice(name: 'Test Fan', speed: 0.5);
    for (Room room in rooms) {
      for (Device dev in room.devices) {
        if (dev.runtimeType == deviceType.runtimeType) {
          setState(() {
            dev.isOn = newStatus == SwitchStatus.off ? false : true;
          });
        }
      }
    }
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

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [

                //     HomeSystemRoomsTab(rooms: rooms),
                //   ],
                // ),

                // SizedBox(
                //   height: 800,
                //   child: HomeSystemRoomsTab(rooms: rooms),
                // ),
                HomeSystemRoomsTab(rooms: rooms),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
