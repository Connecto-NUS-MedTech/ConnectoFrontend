import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    var homeSystemState = Provider.of<HomeSystemState>(context);

    const bookmarkButton = Row(
      children: [
        Icon(Icons.add_circle_outline),
        SizedBox(width: 8),
        Text(
          'Bookmark Room',
          style: TextStyle(fontSize: 20),
        ),
      ],
    );

    var gestureDetector = homeSystemState.unbookmarkedRooms.isEmpty
        ? const Opacity(
            opacity: 0.5,
            child: bookmarkButton,
          )
        : GestureDetector(
            onTapDown: (TapDownDetails details) {
              showMenu(
                context: context,
                position: RelativeRect.fromLTRB(
                  details.globalPosition.dx,
                  details.globalPosition.dy,
                  details.globalPosition.dx,
                  details.globalPosition.dy,
                ),
                items: homeSystemState.unbookmarkedRooms
                    .map(
                      (room) => PopupMenuItem<Room>(
                        value: room,
                        child: Text(room.name),
                      ),
                    )
                    .toList(),
              ).then((Room? room) {
                if (room == null) return;
                homeSystemState.bookmarkRoom(room);
              });
            },
            child: bookmarkButton,
          );

    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_left),
            iconSize: 40,
            onPressed: homeSystemState.paginateLeft,
          ),
          IconButton(
            icon: const Icon(Icons.arrow_right),
            iconSize: 40,
            onPressed: homeSystemState.paginateRight,
          ),
          gestureDetector,
        ],
      ),
    );
  }
}
