import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/room_devices_tab.dart';
import 'package:flutter/material.dart';

class HomeSystemRoomsTab extends StatefulWidget {
  final List<Room> rooms;

  const HomeSystemRoomsTab({super.key, required this.rooms});

  @override
  State<HomeSystemRoomsTab> createState() => _HomeSystemRoomsTabState();
}

class _HomeSystemRoomsTabState extends State<HomeSystemRoomsTab> {
  void handleRoomAdded(Room newRoom) {
    setState(() {
      widget.rooms.add(newRoom);
    });
  }

  void handleRoomUpdated(Room newRoom) {
    setState(() {
      Room room = widget.rooms.firstWhere((r) => r.name == newRoom.name);
      room.updateRoomDevices(newRoom.devices);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: widget.rooms
          .map(
            (room) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child:
                  RoomDevicesTab(room: room, onRoomUpdated: handleRoomUpdated),
            ),
          )
          .toList(),
    );
  }
}
