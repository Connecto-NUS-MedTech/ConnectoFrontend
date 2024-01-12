import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/edit_dialog.dart';
import 'package:flutter/material.dart';

enum MenuOptions { moveLeft, moveRight, editRoom, removeRoom }

class RoomSettingsMenu extends StatelessWidget {
  final Room room;
  final Function(Room) onRoomUpdated;
  final Function(Room) onRoomDeleted;

  const RoomSettingsMenu({
    super.key,
    required this.room,
    required this.onRoomUpdated,
    required this.onRoomDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOptions>(
      icon: const Icon(Icons.more_vert),
      onSelected: (MenuOptions option) {
        // TODO: Add logic for move left, right, edit
        switch (option) {
          case MenuOptions.moveRight:
            break;
          case MenuOptions.moveLeft:
            break;
          case MenuOptions.editRoom:
            onRoomUpdated(room);
            break;
          case MenuOptions.removeRoom:
            onRoomDeleted(room);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.moveLeft,
          child: Row(
            children: <Widget>[
              Icon(Icons.arrow_forward),
              Text('Move right'),
            ],
          ),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.moveLeft,
          child: Row(
            children: <Widget>[
              Icon(Icons.arrow_back),
              Text('Move Left'),
            ],
          ),
        ),
        PopupMenuItem<MenuOptions>(
          value: MenuOptions.editRoom,
          child: EditDialog(
            field: 'Name',
            value: room.name,
            onEditSaved: (String roomName) {
              room.rename(roomName);
              onRoomUpdated(room);
              Navigator.pop(context);
            },
            child: const Row(
              children: <Widget>[
                Icon(Icons.edit),
                Text('Edit room'),
              ],
            ),
          ),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.removeRoom,
          child: Row(
            children: <Widget>[
              Icon(Icons.remove_circle_outline, color: Colors.red),
              Text(
                'Remove room',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
