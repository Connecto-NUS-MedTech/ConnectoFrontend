import 'dart:math';

import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/screens/main_dashboard/main_dashboard.dart';
import 'package:connectofrontend/widgets/home_system/room/room_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSystemRoomsTab extends StatefulWidget {
  final ToggleMainSwitchCallback allSwitchStatus;

  const HomeSystemRoomsTab({
    super.key,
    required this.allSwitchStatus,
  });

  @override
  State<HomeSystemRoomsTab> createState() => _HomeSystemRoomsTabState();
}

class _HomeSystemRoomsTabState extends State<HomeSystemRoomsTab> {
  @override
  Widget build(BuildContext context) {
    var homeSystemState = Provider.of<HomeSystemState>(context);
    int index = homeSystemState.index;
    // `rooms` depends on the screen this belongs to (use a prop in the future?)
    List<Room> rooms = homeSystemState.bookmarkedRooms;

    // When one switch in device tab changes, check if all switches have the same status
    bool checkAllSwitches(Device device, bool deviceStatus) {
      Type deviceType =
          device.runtimeType == LightDevice ? LightDevice : FanDevice;

      for (Room room in rooms) {
        for (Device dev in room.devices) {
          if (dev.runtimeType == deviceType && dev.isOn != deviceStatus) {
            widget.allSwitchStatus(false, deviceType, deviceStatus);
            return false;
          }
        }
      }
      widget.allSwitchStatus(true, deviceType, deviceStatus);
      return true;
    }

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rooms.isEmpty
            ? <Widget>[] // Consider replacing with a prompt to bookmark rooms?
            : rooms
                .sublist(index, min(index + 2, rooms.length))
                .map(
                  (room) => SizedBox(
                    width:
                        // 72 is the size of the navigation bar, 32 is the margin
                        (MediaQuery.of(context).size.width - 72 - 8 - 32) / 2,
                    child: Container(
                      margin: const EdgeInsets.only(right: 32),
                      child: RoomTab(
                        room: room,
                        onDeviceSwitchToggled: checkAllSwitches,
                      ),
                    ),
                  ),

                  // LayoutBuilder(
                  //   builder: (context, constraints) {
                  //     final itemWidth = constraints.maxWidth / 2 - 32;
                  //     return SizedBox(
                  //       width: itemWidth,
                  //       child: RoomTab(
                  //         room: room,
                  //         onDeviceSwitchToggled: checkAllSwitches,
                  //       ),
                  //     );
                  //   },
                  // ),
                )
                .toList(),
      ),
    );
  }
}
