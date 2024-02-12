import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/home_system/add_room_button.dart';
import 'package:connectofrontend/widgets/home_system/bookmark_room_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum Screen { mainDashboard, homeSystem }

class HomeSystemHeaderRow extends StatefulWidget {
  final Screen parentScreen;
  final String rowTitle;
  final IconData buttonIcon;
  final String buttonText;

  const HomeSystemHeaderRow({
    required this.parentScreen,
    super.key,
  })  : rowTitle = (parentScreen == Screen.mainDashboard)
            ? 'Bookmark Rooms'
            : 'My Rooms',
        buttonIcon = (parentScreen == Screen.mainDashboard)
            ? Icons.bookmark_add_rounded
            : Icons.add,
        buttonText = (parentScreen == Screen.mainDashboard)
            ? 'Bookmark Room'
            : 'Add Room';

  @override
  State<HomeSystemHeaderRow> createState() => _HomeSystemHeaderRowState();
}

class _HomeSystemHeaderRowState extends State<HomeSystemHeaderRow> {
  final Color _primaryColor = const Color(0xFF455A64);

  @override
  Widget build(BuildContext context) {
    var homeSystemState = Provider.of<HomeSystemState>(context);

    final headerRowButtonUi = Container(
      decoration: BoxDecoration(
        color: _primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: Row(
        children: [
          Icon(
            widget.buttonIcon,
            color: const Color(0xFFFFFFFF),
          ),
          const SizedBox(width: 8),
          Text(
            widget.buttonText,
            style: const TextStyle(
              fontSize: 16,
              // fontWeight: FontWeight.w500,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
    );

    final paginateLeftButton = GestureDetector(
      onTap: () => homeSystemState.paginateLeft(widget.parentScreen),
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
      onTap: () => homeSystemState.paginateRight(widget.parentScreen),
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

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                widget.rowTitle,
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  paginateLeftButton,
                  const SizedBox(width: 16),
                  paginateRightButton,
                  const SizedBox(width: 16),
                  widget.parentScreen == Screen.mainDashboard
                      ? BookmarkRoomButton(child: headerRowButtonUi)
                      : AddRoomButton(child: headerRowButtonUi),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
