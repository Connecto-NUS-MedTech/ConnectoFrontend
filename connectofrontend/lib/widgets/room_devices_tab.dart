import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/custom_switch.dart';
import 'package:connectofrontend/widgets/device_settings_menu.dart';
import 'package:connectofrontend/widgets/room_settings_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                      onDeviceUpdated: (Device device, [String? newName]) {
                        // * Missing case -- device name updated
                        setState(() {
                          widget.room.updateRoomDevice(device);
                        });
                      },
                      onDeviceDeleted: (Device device) {
                        setState(() {
                          widget.room.removeDevice(device);
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            GestureDetector(
              onTap: () => _showAddDeviceDialog(context, widget.room),
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

class DeviceTab extends StatefulWidget {
  final Device device;
  final Function(Device, [String? newName]) onDeviceUpdated;
  final Function(Device) onDeviceDeleted;

  const DeviceTab({
    super.key,
    required this.device,
    required this.onDeviceUpdated,
    required this.onDeviceDeleted,
  });

  @override
  State<DeviceTab> createState() => _DeviceTabState();
}

class _DeviceTabState extends State<DeviceTab> {
  // Change status of device when switch is toggled
  void updateSwitch(SwitchStatus status) {
    setState(() {
      widget.device.isOn = status == SwitchStatus.on;
    });

    // OR once the state changes, go to main dashboard and trigger a function that checks if all devices are off
    // pass the change to main dashboard
  }

  @override
  Widget build(BuildContext context) {
    String deviceIcon = widget.device is LightDevice
        ? 'assets/icons/lightbulb.svg'
        : 'assets/icons/fan.svg';

    String deviceFeature =
        widget.device is LightDevice ? 'Brightness' : 'Fan Speed';

    double devicePercentage = widget.device.value;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 24, 32, 24),
        child: Row(
          children: [
            DeviceSettingsMenu(
              device: widget.device,
              onDeviceUpdated: widget.onDeviceUpdated,
              onDeviceDeleted: widget.onDeviceDeleted,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            deviceIcon,
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            widget.device.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      CustomSwitch(
                        value: widget.device.isOn
                            ? SwitchStatus.on
                            : SwitchStatus.off,
                        onChanged: updateSwitch,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        deviceFeature,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${(devicePercentage * 100).round()}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                      // Text(widget.device is LightDevice ? widget.device. : )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Slider(
                    value: widget.device.value,
                    min: 0,
                    max: 1,
                    // TODO: Persist the new value, communicate with IoT device
                    onChanged: (newValue) {
                      setState(() {
                        widget.device.setValue(newValue);
                      });
                    },
                    activeColor: const Color(0xFF455A64),
                    inactiveColor: const Color(0xFFCFD8DC),
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
