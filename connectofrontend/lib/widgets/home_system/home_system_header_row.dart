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
  final Color _primaryColor = const Color(0xFF455A64);

  @override
  Widget build(BuildContext context) {
    var homeSystemState = Provider.of<HomeSystemState>(context);

    final bookmarkButton = Container(
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: const Row(
        children: [
          Icon(
            Icons.bookmark_add_rounded,
            color: Color(0xFFFFFFFF),
          ),
          SizedBox(width: 8),
          Text(
            'Bookmark Room',
            style: TextStyle(
              fontSize: 16,
              // fontWeight: FontWeight.w500,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
    );

    final paginateLeftButton = GestureDetector(
      onTap: homeSystemState.paginateLeft,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: _primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_left,
              color: _primaryColor,
            ),
            Text(
              'Prev page',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _primaryColor,
              ),
            ),
          ],
        ),
      ),
    );

    final paginateRightButton = GestureDetector(
      onTap: homeSystemState.paginateRight,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: _primaryColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              Icons.arrow_right,
              color: _primaryColor,
            ),
            Text(
              'Next page',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _primaryColor,
              ),
            ),
          ],
        ),
      ),
    );

    var gestureDetector = homeSystemState.unbookmarkedRooms.isEmpty
        ? Opacity(
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
      margin: const EdgeInsets.only(top: 40, bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            children: [
              Text(
                'Bookmarked Rooms',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  paginateLeftButton,
                  const SizedBox(
                    width: 16,
                  ),
                  paginateRightButton,
                  const SizedBox(
                    width: 16,
                  ),
                  gestureDetector,
                ],
              ),
            ],
          ),
        ],
      ),
      // Row(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     paginateLeftButton,
      //     const SizedBox(
      //       width: 16,
      //     ),
      //     paginateRightButton,
      //     const SizedBox(
      //       width: 16,
      //     ),
      //     gestureDetector,
      //   ],
      // ),
    );
  }
}
