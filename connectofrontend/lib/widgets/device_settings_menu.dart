import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/widgets/edit_dialog.dart';
import 'package:flutter/material.dart';

enum _DeviceOption { editDevice, removeDevice }

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
    return PopupMenuButton<_DeviceOption>(
      icon: const Icon(Icons.more_vert),
      onSelected: (_DeviceOption option) {
        switch (option) {
          case _DeviceOption.editDevice:
            onDeviceUpdated(device);
            break;
          case _DeviceOption.removeDevice:
            onDeviceDeleted(device);
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
              onDeviceUpdated(device);
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
