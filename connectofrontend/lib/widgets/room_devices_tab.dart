import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/custom_switch.dart';
import 'package:connectofrontend/widgets/room_settings_menu.dart';
import 'package:flutter/material.dart';

class RoomDevicesTab extends StatefulWidget {
  final Room room;
  final Function(Room) onRoomAdded; // Not in use for now
  final Function(Room) onRoomUpdated;
  final Function(Room) onRoomDeleted;

  const RoomDevicesTab({
    super.key,
    required this.room,
    required this.onRoomAdded,
    required this.onRoomUpdated,
    required this.onRoomDeleted,
  });

  @override
  State<RoomDevicesTab> createState() => _RoomDevicesTabState();
}

class _RoomDevicesTabState extends State<RoomDevicesTab> {
  String selectedDeviceType = 'Fan';
  TextEditingController deviceNameController = TextEditingController();

  Future<void> _showAddDeviceDialog(BuildContext context, Room room) async {
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
                  newDevice = FanDevice(name: deviceNameController.text);
                } else if (selectedDeviceType == 'Light') {
                  newDevice = LightDevice(name: deviceNameController.text);
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

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.room.name,
                  style: const TextStyle(
                    fontSize: 24,
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
            ...widget.room.devices
                .map((device) => DeviceTab(device: device))
                .toList(),
            // TODO: Fix styling issue -- align to the left
            GestureDetector(
              onTap: () => _showAddDeviceDialog(context, widget.room),
              child: const Align(
                // * Doesn't work!?
                // alignment: Alignment.centerLeft,
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.add_circle_outline),
                    Text(
                      'Add Device',
                      // style: TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DeviceTab extends StatefulWidget {
  final Device device;
  const DeviceTab({super.key, required this.device});

  @override
  State<DeviceTab> createState() => _DeviceTabState();
}

class _DeviceTabState extends State<DeviceTab> {
  double value = 0;
  late SwitchStatus deviceState =
      widget.device.isOn ? SwitchStatus.on : SwitchStatus.off;

  void updateSwitch(SwitchStatus status) {
    setState(() {
      deviceState = status;
      widget.device.isOn = status == SwitchStatus.on ? true : false;
    });
    print('Device state for ${widget.device.name}: $deviceState');
    print('Device is: ${widget.device.isOn}');
  }

  @override
  Widget build(BuildContext context) {
    Icon deviceIcon = widget.device is LightDevice
        ? const Icon(Icons.lightbulb, color: Colors.yellow)
        : const Icon(Icons.ac_unit, color: Colors.blue);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: <Widget>[
            Row(
              children: [
                deviceIcon,
                Text(
                  widget.device.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // Switch(
                //   value: widget.device.isOn,
                //   onChanged: (bool newValue) {
                //     setState(() {
                //       widget.device.isOn = newValue;
                //     });
                //   },
                // ),
                CustomSwitch(
                  // value is state of device
                  value: deviceState,
                  onChanged: updateSwitch,
                ),
              ],
            ),
            Slider(
              value: value,
              min: 0,
              max: 1,
              // TODO: Persist the new value, communicate with IoT device
              onChanged: (newValue) {
                setState(() {
                  value = newValue;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
