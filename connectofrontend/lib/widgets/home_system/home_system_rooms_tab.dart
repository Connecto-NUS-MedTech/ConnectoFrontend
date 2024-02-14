import 'dart:math';

import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/home_system/home_system_header_row.dart';
import 'package:connectofrontend/widgets/home_system/room/room_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSystemRoomsTab extends StatefulWidget {
  final Screen parentScreen;
  const HomeSystemRoomsTab({super.key, required this.parentScreen});

  @override
  State<HomeSystemRoomsTab> createState() => _HomeSystemRoomsTabState();
}

class _HomeSystemRoomsTabState extends State<HomeSystemRoomsTab> {
  @override
  Widget build(BuildContext context) {
    var homeSystemState = Provider.of<HomeSystemState>(context);
    int index = widget.parentScreen == Screen.mainDashboard
        ? homeSystemState.bookmarkedRoomsIndex
        : homeSystemState.allRoomsIndex;
    List<Room> rooms = widget.parentScreen == Screen.mainDashboard
        ? homeSystemState.bookmarkedRooms
        : homeSystemState.rooms;

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
                        parentScreen: widget.parentScreen,
                        room: room,
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }
}
