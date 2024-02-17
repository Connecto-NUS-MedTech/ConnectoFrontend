import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/home_system/device/device_tab.dart';
import 'package:connectofrontend/widgets/home_system/home_system_header_row.dart';
import 'package:connectofrontend/widgets/home_system/room/add_device_button.dart';
import 'package:connectofrontend/widgets/home_system/room/room_settings_menu.dart';
import 'package:flutter/material.dart';

class RoomTab extends StatelessWidget {
  final Screen parentScreen;
  final Room room;

  const RoomTab({
    super.key,
    required this.parentScreen,
    required this.room,
  });

  @override
  Widget build(BuildContext context) {
    List<Device> devices = room.devices;
    if (parentScreen == Screen.homeSystem) {
      // Important: create a copy before sorting
      devices = devices.toList()..sort();
    }

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
                  room.name,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RoomSettingsMenu(
                  parentScreen: parentScreen,
                  room: room,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Column(
              children: devices
                  .map(
                    (device) => DeviceTab(
                      parentScreen: parentScreen,
                      room: room,
                      device: device,
                    ),
                  )
                  .toList(),
            ),
            AddDeviceButton(room: room),
          ],
        ),
      ),
    );
  }
}
