import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/home_system/home_system_header_row.dart';
import 'package:flutter/material.dart';

class HomeSystemState with ChangeNotifier {
  // index of first Room to display in MainDashboard and HomeSystem respectively
  int bookmarkedRoomsIndex = 0;
  int allRoomsIndex = 0;

  // Hardcoded for now
  // Currently, these are only for bookmarked rooms
  int numLightsOn = 0;
  int numFansOn = 0;
  int totalLightDevices = 3;
  int totalFanDevices = 2;

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

  void paginateLeft(Screen screen) {
    if (screen == Screen.mainDashboard) {
      if (bookmarkedRoomsIndex <= 0) return;
      bookmarkedRoomsIndex -= 2;
    }
    if (screen == Screen.homeSystem) {
      if (allRoomsIndex <= 0) return;
      allRoomsIndex -= 2;
    }
    notifyListeners();
  }

  void paginateRight(Screen screen) {
    if (screen == Screen.mainDashboard) {
      if (bookmarkedRoomsIndex >= bookmarkedRooms.length - 2) return;
      bookmarkedRoomsIndex += 2;
    }
    if (screen == Screen.homeSystem) {
      if (allRoomsIndex >= rooms.length - 2) return;
      allRoomsIndex += 2;
    }
    notifyListeners();
  }

  void bookmarkRoom(Room room) {
    bookmarkedRooms.add(room);
    totalLightDevices += room.numberOfLightDevices;
    totalFanDevices += room.numberOfFanDevices;
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
    totalLightDevices -= room.numberOfLightDevices;
    totalFanDevices -= room.numberOfFanDevices;
    // check if the room removed was the last room
    if (bookmarkedRoomsIndex == bookmarkedRooms.length &&
        bookmarkedRoomsIndex > 0) {
      bookmarkedRoomsIndex -= 2;
    }
    notifyListeners();
  }

  ///  Device methods
  void updateDeviceStatus(Device device, bool status) {
    if (device.isOn == status) return;
    device.isOn = status;
    if (status) {
      device is LightDevice ? numLightsOn++ : numFansOn++;
    } else {
      device is LightDevice ? numLightsOn-- : numFansOn--;
    }
    notifyListeners();
  }

  // Sets the `isOn` status for all devices of given type
  void setAllDevices(Type deviceType, bool status) {
    for (Room room in bookmarkedRooms) {
      for (Device dev in room.devices) {
        if (dev.runtimeType == deviceType) {
          dev.isOn = status;
        }
      }
    }
    if (deviceType == LightDevice) {
      numLightsOn = status ? totalLightDevices : 0;
    }
    if (deviceType == FanDevice) {
      numFansOn = status ? totalFanDevices : 0;
    }
    notifyListeners();
  }
}
