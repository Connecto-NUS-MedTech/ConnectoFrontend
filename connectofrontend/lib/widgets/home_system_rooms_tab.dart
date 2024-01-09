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
    return Wrap(
      spacing: 32,
      runSpacing: 24,
      children: widget.rooms
          .map(
            (room) => LayoutBuilder(
              builder: (context, constraints) {
                final itemWidth = constraints.maxWidth / 2 - 32;
                return SizedBox(
                  width: itemWidth,
                  child: RoomDevicesTab(
                    room: room,
                    onRoomAdded: handleRoomAdded,
                    onRoomUpdated: handleRoomUpdated,
                    onRoomDeleted: handleRoomDeleted,
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}
