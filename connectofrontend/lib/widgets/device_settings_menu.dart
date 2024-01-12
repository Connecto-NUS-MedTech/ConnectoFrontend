import 'package:connectofrontend/models/device/device.dart';
import 'package:flutter/material.dart';

enum MenuOptions { editDevice, removeDevice }

class DeviceSettingsMenu extends StatelessWidget {
  final Device device;
  final Function(Device) onDeviceUpdated;
  final Function(Device) onDeviceDeleted;

  const DeviceSettingsMenu({
    super.key,
    required this.device,
    required this.onDeviceUpdated,
    required this.onDeviceDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<MenuOptions>(
      icon: const Icon(Icons.more_vert),
      onSelected: (MenuOptions option) {
        switch (option) {
          case MenuOptions.editDevice:
            onDeviceUpdated(device);
            break;
          case MenuOptions.removeDevice:
            onDeviceDeleted(device);
            break;
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.editDevice,
          child: Row(
            children: <Widget>[
              Icon(Icons.edit),
              Text('Edit device'),
            ],
          ),
        ),
        const PopupMenuItem<MenuOptions>(
          value: MenuOptions.removeDevice,
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
