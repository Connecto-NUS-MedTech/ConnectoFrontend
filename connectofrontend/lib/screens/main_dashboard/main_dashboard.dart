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

  // random
  SwitchStatus status = SwitchStatus.off;
  String deviceToToggle = 'Fan';

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
    myMethod.call(deviceToToggle, status);
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
                const HomeSystemHeaderRow(),
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

class HomeSystemHeaderRow extends StatefulWidget {
  const HomeSystemHeaderRow({
    super.key,
  });

  @override
  State<HomeSystemHeaderRow> createState() => _HomeSystemHeaderRowState();
}

class _HomeSystemHeaderRowState extends State<HomeSystemHeaderRow> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_left),
            iconSize: 40,
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.arrow_right),
            iconSize: 40,
            onPressed: () {},
          ),
          GestureDetector(
            // TODO: Show dropdown? Of all the existing rooms
            onTap: () => {},
            child: const Row(
              children: [
                Icon(Icons.add_circle_outline),
                SizedBox(width: 8),
                Text(
                  'Bookmark Room',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
