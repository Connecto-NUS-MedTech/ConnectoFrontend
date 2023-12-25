import 'package:connectofrontend/models/device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/custom_switch.dart';
import 'package:flutter/material.dart';

class RoomDevicesTab extends StatefulWidget {
  final Room room;

  const RoomDevicesTab({
    super.key,
    required this.room,
  });

  @override
  State<RoomDevicesTab> createState() => _RoomDevicesTabState();
}

class _RoomDevicesTabState extends State<RoomDevicesTab> {
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
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
            ...widget.room.devices
                .map((device) => DeviceTab(device: device))
                .toList(),
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
  // initialise this whenever devicestate changes
  // late SwitchStatus deviceState =
  //     widget.device.isOn ? SwitchStatus.on : SwitchStatus.off;
  // late SwitchStatus deviceState;

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize deviceState in the initState method
  //   deviceState = widget.device.isOn ? SwitchStatus.on : SwitchStatus.off;
  // }

  // @override
  // void didUpdateWidget(covariant DeviceTab oldWidget) {
  //   print('update hereee');
  //   print('oldWidget, ${oldWidget.device.name} is ${oldWidget.device.isOn}');
  //   print('curr widget, ${widget.device.name} is ${widget.device.isOn}');
  //   super.didUpdateWidget(oldWidget);
  //   // Re-evaluate deviceState when widget.device.isOn changes
  //   if (widget.device.isOn != oldWidget.device.isOn) {
  //     setState(() {
  //       print('before setting state');
  //       deviceState = widget.device.isOn ? SwitchStatus.on : SwitchStatus.off;
  //       print('dones');
  //     });
  //   }
  // }

  // Change status of device when switch is toggled
  void updateSwitch(SwitchStatus status) {
    setState(() {
      // deviceState = status;
      widget.device.isOn = status == SwitchStatus.on ? true : false;
    });
    // print('Device state for ${widget.device.name}: $deviceState');
    print('Device is: ${widget.device.isOn}');
    // check if the main switch should change
    // OR once the state changes, go to main dashboard and trigger a function that checks if all devices are off
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
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // TESTING
                Text(widget.device.isOn.toString()),
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
                  value:
                      widget.device.isOn ? SwitchStatus.on : SwitchStatus.off,
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
