import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/home_system/edit_dialog.dart';
import 'package:connectofrontend/widgets/home_system/home_system_header_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _RoomOption {
  moveToFront,
  moveLeft,
  moveRight,
  editRoom,
  unbookmarkRoom,
  deleteRoom
}

class RoomSettingsMenu extends StatelessWidget {
  final Screen parentScreen;
  final Room room;

  const RoomSettingsMenu({
    super.key,
    required this.parentScreen,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    var homeSystemState = Provider.of<HomeSystemState>(context, listen: false);

    return PopupMenuButton<_RoomOption>(
      icon: const Icon(Icons.more_vert),
      onSelected: (_RoomOption option) {
        switch (option) {
          case _RoomOption.moveToFront:
            break;
          case _RoomOption.moveLeft:
            break;
          case _RoomOption.moveRight:
            break;
          case _RoomOption.editRoom:
            homeSystemState.updateRoom(room);
            break;
          case _RoomOption.unbookmarkRoom:
            homeSystemState.unbookmarkRoom(room);
            break;
          case _RoomOption.deleteRoom:
            homeSystemState.deleteRoom(room);
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<_RoomOption>> menuItems = [
          const PopupMenuItem<_RoomOption>(
            value: _RoomOption.moveRight,
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_forward),
                SizedBox(width: 8),
                Text('Move right'),
              ],
            ),
          ),
          const PopupMenuItem<_RoomOption>(
            value: _RoomOption.moveLeft,
            child: Row(
              children: <Widget>[
                Icon(Icons.arrow_back),
                SizedBox(width: 8),
                Text('Move left'),
              ],
            ),
          ),
        ];

        if (parentScreen == Screen.mainDashboard) {
          menuItems.insert(
            0,
            const PopupMenuItem<_RoomOption>(
              value: _RoomOption.moveToFront,
              child: Row(
                children: <Widget>[
                  Icon(Icons.arrow_back),
                  SizedBox(width: 8),
                  Text('Move to front'),
                ],
              ),
            ),
          );
          menuItems.add(
            const PopupMenuItem<_RoomOption>(
              value: _RoomOption.unbookmarkRoom,
              child: Row(
                children: <Widget>[
                  Icon(Icons.remove_circle_outline, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    'Remove bookmark',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        }
        if (parentScreen == Screen.homeSystem) {
          menuItems.add(
            PopupMenuItem<_RoomOption>(
              value: _RoomOption.editRoom,
              child: EditDialog(
                field: 'Name',
                value: room.name,
                onEditSaved: (String roomName) {
                  room.rename(roomName);
                  homeSystemState.updateRoom(room);
                  Navigator.pop(context);
                },
                child: const Row(
                  children: <Widget>[
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Edit room'),
                  ],
                ),
              ),
            ),
          );
          menuItems.add(
            const PopupMenuItem<_RoomOption>(
              value: _RoomOption.deleteRoom,
              child: Row(
                children: <Widget>[
                  Icon(Icons.remove_circle_outline, color: Colors.red),
                  SizedBox(width: 8),
                  Text(
                    'Delete room',
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        }

        return menuItems;
      },
    );
  }
}
