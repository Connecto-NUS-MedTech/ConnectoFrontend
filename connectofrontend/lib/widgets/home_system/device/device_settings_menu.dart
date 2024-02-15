import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/home_system/edit_dialog.dart';
import 'package:connectofrontend/widgets/home_system/home_system_header_row.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum _DeviceOption { editDevice, removeDevice, moveToTop, moveUp, moveDown }

class DeviceSettingsMenu extends StatelessWidget {
  final Screen parentScreen;
  final Room room;
  final Device device;

  const DeviceSettingsMenu({
    super.key,
    required this.room,
    required this.device,
    required this.parentScreen,
  });

  @override
  Widget build(BuildContext context) {
    var homeSystemState = Provider.of<HomeSystemState>(context);

    return PopupMenuButton<_DeviceOption>(
      icon: const Icon(Icons.more_vert),
      onSelected: (_DeviceOption option) {
        switch (option) {
          case _DeviceOption.moveToTop:
            room.moveToTop(device);
            homeSystemState.updateRoom(room);
            break;
          case _DeviceOption.moveUp:
            room.moveDeviceUp(device);
            homeSystemState.updateRoom(room);
            break;
          case _DeviceOption.moveDown:
            room.moveDeviceDown(device);
            homeSystemState.updateRoom(room);
            break;
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
      itemBuilder: (BuildContext context) {
        List<PopupMenuEntry<_DeviceOption>> menuItems = [
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
                  SizedBox(width: 8),
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
                SizedBox(width: 8),
                Text(
                  'Remove device',
                  style: TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ];

        if (parentScreen == Screen.mainDashboard) {
          menuItems.insert(
            0,
            const PopupMenuItem<_DeviceOption>(
              value: _DeviceOption.moveToTop,
              child: Row(
                children: <Widget>[
                  Icon(Icons.move_up),
                  SizedBox(width: 8),
                  Text('Move to top'),
                ],
              ),
            ),
          );
          menuItems.insert(
            1,
            const PopupMenuItem<_DeviceOption>(
              value: _DeviceOption.moveUp,
              child: Row(
                children: <Widget>[
                  Icon(Icons.arrow_upward),
                  SizedBox(width: 8),
                  Text('Move up'),
                ],
              ),
            ),
          );
          menuItems.insert(
            2,
            const PopupMenuItem<_DeviceOption>(
              value: _DeviceOption.moveDown,
              child: Row(
                children: <Widget>[
                  Icon(Icons.arrow_downward),
                  SizedBox(width: 8),
                  Text('Move down'),
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
