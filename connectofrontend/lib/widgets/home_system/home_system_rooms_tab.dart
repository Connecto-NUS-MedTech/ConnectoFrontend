import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/home_system/room/room_tab.dart';
import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/screens/main_dashboard/main_dashboard.dart';
import 'package:flutter/material.dart';

class HomeSystemRoomsTab extends StatefulWidget {
  final List<Room> rooms;
  final ToggleMainSwitchCallback allSwitchStatus;

  const HomeSystemRoomsTab({
    super.key,
    required this.rooms,
    required this.allSwitchStatus,
  });

  @override
  State<HomeSystemRoomsTab> createState() => _HomeSystemRoomsTabState();
}

class _HomeSystemRoomsTabState extends State<HomeSystemRoomsTab> {
  // Not in use for now
  void handleRoomAdded(Room room) {
    setState(() {
      widget.rooms.add(room);
    });
  }

  void handleRoomUpdated(Room newRoom) {
    setState(() {
      int roomIndex = widget.rooms.indexWhere((r) => r.id == newRoom.id);
      if (roomIndex != -1) {
        widget.rooms[roomIndex] = newRoom;
      }
    });
  }

  void handleRoomDeleted(Room room) {
    setState(() {
      widget.rooms.remove(room);
    });
  }

  // When one switch in device tab changes, check if all switches have the same status
  bool checkAllSwitches(Device device, bool deviceStatus) {
    Type deviceType =
        device.runtimeType == LightDevice ? LightDevice : FanDevice;

    for (Room room in widget.rooms) {
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

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 32,
      // runSpacing: 24,
      children: widget.rooms
          .map(
            (room) => LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / 2 - 32;
                return SizedBox(
                  width: itemWidth,
                  child: RoomTab(
                    room: room,
                    onRoomAdded: handleRoomAdded,
                    onRoomUpdated: handleRoomUpdated,
                    onRoomDeleted: handleRoomDeleted,
                    onDeviceSwitchToggled: checkAllSwitches,
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}
