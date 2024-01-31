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
  List<Room> bookmarkedRooms = [
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
      id: 4,
      name: 'Test 2',
      devices: [
        LightDevice(id: 0, name: 'Light 1', brightness: 0.5),
        LightDevice(id: 0, name: 'Light 2', brightness: 0.5),
      ],
    ),
  ];
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
      id: 3,
      name: 'Test 1',
      devices: [
        LightDevice(id: 0, name: 'Light 1', brightness: 0.5),
        FanDevice(id: 0, name: 'Fan 2', speed: 0.8),
      ],
    ),
    Room(
      id: 4,
      name: 'Test 2',
      devices: [
        LightDevice(id: 0, name: 'Light 1', brightness: 0.5),
        LightDevice(id: 0, name: 'Light 2', brightness: 0.5),
      ],
    ),
  ];

  List<Room> get unbookmarkedRooms => Set<Room>.from(rooms)
      .difference(Set<Room>.from(bookmarkedRooms))
      .toList();

  void paginateLeft() {
    if (index > 0) {
      index -= 2;
    }
    notifyListeners();
  }

  // TODO: Update to take in arg for screen type
  void paginateRight() {
    if (index < bookmarkedRooms.length - 2) {
      index += 2;
    }
    notifyListeners();
  }

  void bookmarkRoom(Room room) {
    bookmarkedRooms.add(room);
    notifyListeners();
  }

  void updateRoom(Room newRoom) {
    int index1 = bookmarkedRooms.indexWhere((r) => r.id == newRoom.id);
    int index2 = rooms.indexWhere((r) => r.id == newRoom.id);
    if (index1 != -1) {
      bookmarkedRooms[index1] = newRoom;
    }
    if (index1 != -1) {
      rooms[index2] = newRoom;
    }
    notifyListeners();
  }

  void unbookmarkRoom(Room room) {
    bookmarkedRooms.remove(room);
    // check if the room removed was the last room
    if (index == bookmarkedRooms.length && index > 0) {
      index -= 2;
    }
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
