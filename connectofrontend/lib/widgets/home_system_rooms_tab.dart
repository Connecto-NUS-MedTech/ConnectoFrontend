import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/room_devices_tab.dart';
import 'package:flutter/material.dart';

class HomeSystemRoomsTab extends StatelessWidget {
  final List<Room> rooms;

  const HomeSystemRoomsTab({super.key, required this.rooms});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rooms
          .map(
            (room) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              child: RoomDevicesTab(room: room),
            ),
          )
          .toList(),
    );
  }
}
