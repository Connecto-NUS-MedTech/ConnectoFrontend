import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookmarkRoomButton extends StatefulWidget {
  final Widget child;
  const BookmarkRoomButton({super.key, required this.child});

  @override
  State<BookmarkRoomButton> createState() => _BookmarkRoomButtonState();
}

class _BookmarkRoomButtonState extends State<BookmarkRoomButton> {
  @override
  Widget build(BuildContext context) {
    var homeSystemState = Provider.of<HomeSystemState>(context, listen: false);
    return homeSystemState.unbookmarkedRooms.isEmpty
        ? Opacity(
            opacity: 0.5,
            child: widget.child,
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
            child: widget.child,
          );
  }
}
