import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/home_system/custom_switch.dart';
import 'package:connectofrontend/widgets/home_system/home_system_rooms_tab.dart';
import 'package:connectofrontend/widgets/home_system/home_env_control.dart';

import 'package:flutter/material.dart';

typedef ToggleMainSwitchCallback = void Function(
  bool toToggle,
  Type deviceType,
  bool deviceStatus,
);

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => MainDashboardScreenState();
}

class MainDashboardScreenState extends State<MainDashboardScreen> {
  late void Function(String deviceType, SwitchStatus staus) myMethod;
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

  SwitchStatus status = SwitchStatus.neither;
  // random
  String deviceToToggle = 'Fan';

// pass this to HECC -> pass to MC
// called when individual device switch is toggled
  void onAllSwitchStatusChanged(
    bool toToggle,
    Type deviceType,
    bool deviceStatus,
  ) {
    // toToggle == true means the master switch needs to change
    if (toToggle) {
      setState(() {
        status = deviceStatus == true ? SwitchStatus.on : SwitchStatus.off;
        deviceToToggle = deviceType == FanDevice ? 'Fan' : 'Light';
      });
    } else {
      // no need to toggle - passes neither and curr device
      setState(() {
        status = SwitchStatus.neither;
        deviceToToggle = deviceType == FanDevice ? 'Fan' : 'Light';
      });
    }
    print('status in MD: $deviceStatus and toToggle: $toToggle');
    myMethod.call(deviceToToggle, status);
    // print(
    //     'in MD SAME? device Type is $deviceType, device to toggle is $deviceToToggle');
    // print('Received value from HomeSystemRoomsTab to toggle?: $toToggle');
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
                HomeEnvironmentalConditionsControlTab(
                  rooms: rooms,
                  onChanged: toggleAllDevices,
                  // these are for if the switches in MasterCard need to change when the devices' status changes
                  newStatus: status,
                  newDevice: deviceToToggle,
                  builder: (
                    BuildContext context,
                    void Function(String deviceType, SwitchStatus staus)
                        methodFromChild,
                  ) {
                    myMethod = methodFromChild;
                  },
                ),
                const SizedBox(
                  height: 25,
                ),
                HomeSystemRoomsTab(
                  rooms: rooms,
                  allSwitchStatus: onAllSwitchStatusChanged,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
