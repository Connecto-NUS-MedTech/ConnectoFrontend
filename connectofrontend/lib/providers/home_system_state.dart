import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/home_system/custom_switch.dart';
import 'package:flutter/material.dart';

class HomeSystemState with ChangeNotifier {
  // index of first Room to display in MainDashboard 
  int index = 0;
  // Hardcoded for now -- fetch from DB or local storage in the future
  List<Room> rooms = [
    Room(
      id: 0,
      name: 'Hallway',
      devices: [
        LightDevice(id: 0, name: 'Light 1', brightness: 0.5),
        FanDevice(id: 0, name: 'Fan 1', speed: 0.8),
        FanDevice(id: 0, name: 'Fan 2', speed: 0.8),
      ],
    ),
    Room(
      id: 1,
      name: 'Kitchen',
      devices: [
        LightDevice(id: 0, name: 'Light 1', brightness: 0.5),
        LightDevice(id: 0, name: 'Light 2', brightness: 0.5),
      ],
    ),
    // FOR TESTING, DELETE LATER
    Room(
      id: 0,
      name: 'Test 1',
      devices: [
        LightDevice(id: 0, name: 'Light 1', brightness: 0.5),
        FanDevice(id: 0, name: 'Fan 2', speed: 0.8),
      ],
    ),
    Room(
      id: 0,
      name: 'Test 2',
      devices: [
        LightDevice(id: 0, name: 'Light 1', brightness: 0.5),
        LightDevice(id: 0, name: 'Light 2', brightness: 0.5),
      ],
    ),
  ];

  void paginateLeft() {
    if (index > 0) {
      index -= 2;
    }
    notifyListeners();
  }

  void paginateRight() {
    if (index < rooms.length - 2) {
      index += 2;
    }
    notifyListeners();
  }

  // Currently not in use
  // void addRoom(Room room) {
  //   rooms.add(room);
  //   notifyListeners();
  // }

  void updateRoom(Room newRoom) {
    int roomIndex = rooms.indexWhere((r) => r.id == newRoom.id);
    if (roomIndex != -1) {
      rooms[roomIndex] = newRoom;
    }
    notifyListeners();
  }

  void deleteRoom(Room room) {
    rooms.remove(room);
    notifyListeners();
  }

  void toggleAllDevices(String cardText, SwitchStatus newStatus) {
    Device deviceType = cardText == 'ALL LIGHTS'
        ? LightDevice(id: 0, name: 'Test Light', brightness: 0.5)
        : FanDevice(id: 0, name: 'Test Fan', speed: 0.5);
    for (Room room in rooms) {
      for (Device dev in room.devices) {
        if (dev.runtimeType == deviceType.runtimeType) {
          dev.isOn = newStatus != SwitchStatus.off;
        }
      }
    }
    notifyListeners();
  }
}
