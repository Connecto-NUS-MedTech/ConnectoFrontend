import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddDeviceButton extends StatefulWidget {
  final Room room;
  const AddDeviceButton({super.key, required this.room});

  @override
  State<AddDeviceButton> createState() => _AddDeviceButtonState();
}

class _AddDeviceButtonState extends State<AddDeviceButton> {
  String selectedDeviceType = 'Fan';
  TextEditingController deviceNameController = TextEditingController();

  @override
  void dispose() {
    deviceNameController.dispose();
    super.dispose();
  }

  Future<void> _showAddDeviceDialog(BuildContext context) async {
    var updateRoom =
        Provider.of<HomeSystemState>(context, listen: false).updateRoom;
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
                try {
                  widget.room.addDevice(newDevice);
                  updateRoom(widget.room);
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
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
    return GestureDetector(
      onTap: () => _showAddDeviceDialog(context),
      child: const Row(
        children: [
          Icon(Icons.add_circle_outline),
          SizedBox(width: 8),
          Text(
            'Add Device',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
