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
  // Not in use for now
  void handleRoomAdded(Room room) {
    setState(() {
      widget.rooms.add(room);
    });
  }

  void handleRoomUpdated(Room newRoom) {
    // * See if widget re-renders if room is updated
    setState(() {
      // Room room = widget.rooms.firstWhere((r) => r.name == newRoom.name);
      // room.updateRoomDevices(newRoom.devices);
    });
  }

  void handleRoomDeleted(Room room) {
    setState(() {
      widget.rooms.remove(room);
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
              child: RoomDevicesTab(
                room: room,
                onRoomAdded: handleRoomAdded,
                onRoomUpdated: handleRoomUpdated,
                onRoomDeleted: handleRoomDeleted,
              ),
            ),
          )
          .toList(),
    );
  }
}
