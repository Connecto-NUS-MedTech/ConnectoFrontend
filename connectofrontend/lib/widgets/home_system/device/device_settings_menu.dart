import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/home_system/edit_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _DeviceOption { editDevice, removeDevice }

class DeviceSettingsMenu extends StatelessWidget {
  final Room room;
  final Device device;

  const DeviceSettingsMenu({
    super.key,
    required this.room,
    required this.device,
  });

  @override
  Widget build(BuildContext context) {
    var homeSystemState = Provider.of<HomeSystemState>(context);

    return PopupMenuButton<_DeviceOption>(
      icon: const Icon(Icons.more_vert),
      onSelected: (_DeviceOption option) {

        switch (option) {
          case _DeviceOption.editDevice:
            // TODO: Catch duplicate name errors
            room.updateRoomDevice(device);
            homeSystemState.updateRoom(room);
            break;
          case _DeviceOption.removeDevice:
            room.removeDevice(device);
            homeSystemState.updateRoom(room);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<_DeviceOption>>[
        PopupMenuItem<_DeviceOption>(
          value: _DeviceOption.editDevice,
          child: EditDialog(
            field: 'Name',
            value: device.name,
            onEditSaved: (String deviceName) {
              device.rename(deviceName);
              homeSystemState.updateRoom(room);
              Navigator.pop(context);
            },
            child: const Row(
              children: <Widget>[
                Icon(Icons.edit),
                Text('Edit device'),
              ],
            ),
          ),
        ),
        const PopupMenuItem<_DeviceOption>(
          value: _DeviceOption.removeDevice,
          child: Row(
            children: <Widget>[
              Icon(Icons.remove_circle_outline, color: Colors.red),
              Text(
                'Remove device',
                style: TextStyle(color: Colors.red),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
