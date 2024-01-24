import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/home_system/custom_switch.dart';
import 'package:connectofrontend/widgets/home_system/home_env_control.dart';
import 'package:connectofrontend/widgets/home_system/home_system_header_row.dart';
import 'package:connectofrontend/widgets/home_system/home_system_rooms_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    List<Room> rooms = Provider.of<HomeSystemState>(context).rooms;

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
                  // * use bookmarkedRooms instead if this is not meant to control ALL rooms
                  rooms: rooms,
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
