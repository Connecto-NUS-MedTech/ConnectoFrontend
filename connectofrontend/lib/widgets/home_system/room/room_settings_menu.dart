import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/home_system/edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _RoomOption { moveLeft, moveRight, editRoom, unbookmarkRoom }

class RoomSettingsMenu extends StatelessWidget {
  final Room room;

  const RoomSettingsMenu({
    super.key,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    var updateRoom =
        Provider.of<HomeSystemState>(context, listen: false).updateRoom;
    var unbookmarkRoom =
        Provider.of<HomeSystemState>(context, listen: false).unbookmarkRoom;

    return PopupMenuButton<_RoomOption>(
      icon: const Icon(Icons.more_vert),
      onSelected: (_RoomOption option) {
        // TODO: Add logic for move left, right, edit
        // TODO: Differentiate between deleting Room and unbookmarking Room
        switch (option) {
          case _RoomOption.moveRight:
            break;
          case _RoomOption.moveLeft:
            break;
          case _RoomOption.editRoom:
            updateRoom(room);
            break;
          case _RoomOption.unbookmarkRoom:
            unbookmarkRoom(room);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<_RoomOption>>[
        const PopupMenuItem<_RoomOption>(
          value: _RoomOption.moveLeft,
          child: Row(
            children: <Widget>[
              Icon(Icons.arrow_forward),
              Text('Move right'),
            ],
          ),
        ),
        const PopupMenuItem<_RoomOption>(
          value: _RoomOption.moveLeft,
          child: Row(
            children: <Widget>[
              Icon(Icons.arrow_back),
              Text('Move Left'),
            ],
          ),
        ),
        PopupMenuItem<_RoomOption>(
          value: _RoomOption.editRoom,
          child: EditDialog(
            field: 'Name',
            value: room.name,
            onEditSaved: (String roomName) {
              room.rename(roomName);
              updateRoom(room);
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
        const PopupMenuItem<_RoomOption>(
          value: _RoomOption.unbookmarkRoom,
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
