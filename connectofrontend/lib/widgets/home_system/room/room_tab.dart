import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/home_system/device/device_tab.dart';
import 'package:connectofrontend/widgets/home_system/room/room_settings_menu.dart';
import 'package:flutter/material.dart';

class RoomTab extends StatefulWidget {
  final Room room;
  final Function(Room) onRoomAdded; // Not in use for now
  final Function(Room) onRoomUpdated;
  final Function(Room) onRoomDeleted;
  final Function(Device, bool) onDeviceSwitchToggled;

  const RoomTab({
    super.key,
    required this.room,
    required this.onRoomAdded,
    required this.onRoomUpdated,
    required this.onRoomDeleted,
    required this.onDeviceSwitchToggled,
  });

  @override
  State<RoomTab> createState() => _RoomTabState();
}

class _RoomTabState extends State<RoomTab> {
  String selectedDeviceType = 'Fan';
  TextEditingController deviceNameController = TextEditingController();

  @override
  void dispose() {
    deviceNameController.dispose();
    super.dispose();
  }

  Future<void> _showAddDeviceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Device'),
          content: Column(
            children: [
              TextField(
                controller: deviceNameController,
                decoration: const InputDecoration(labelText: 'Device Name'),
              ),
              DropdownButton<String>(
                value: selectedDeviceType,
                items: <String>['Fan', 'Light'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedDeviceType = newValue!;
                  });
                },
              ),
              TextField(
                controller: TextEditingController()..text = widget.room.name,
                decoration: const InputDecoration(
                  labelText: 'Room',
                ),
                readOnly: true,
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                deviceNameController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Device newDevice;
                if (selectedDeviceType == 'Fan') {
                  newDevice = FanDevice(id: 0, name: deviceNameController.text);
                } else if (selectedDeviceType == 'Light') {
                  newDevice =
                      LightDevice(id: 1, name: deviceNameController.text);
                } else {
                  throw Exception('Invalid device type');
                }

                widget.room.addDevice(newDevice);
                widget.onRoomUpdated(widget.room);
                deviceNameController.clear();

                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void passSwitchData(Device device, bool deviceStatus) {
    widget.onDeviceSwitchToggled(device, deviceStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(1, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.room.name,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RoomSettingsMenu(
                  room: widget.room,
                  onRoomUpdated: widget.onRoomUpdated,
                  onRoomDeleted: widget.onRoomDeleted,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              children: widget.room.devices
                  .map(
                    (device) => DeviceTab(
                      device: device,
                      onDeviceUpdated: (Device device) {
                        setState(() {
                          widget.room.updateRoomDevice(device);
                        });
                      },
                      onDeviceDeleted: (Device device) {
                        setState(() {
                          widget.room.removeDevice(device);
                        });
                      },
                      onSwitchChanged: passSwitchData,
                    ),
                  )
                  .toList(),
            ),
            GestureDetector(
              onTap: () => _showAddDeviceDialog(context),
              child: const Row(
                children: [
                  Icon(Icons.add_circle_outline),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    'Add Device',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
