import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';

class Room {
  final int id;
  String name;
  final List<Device> devices;

  Room({
    required this.id,
    required this.name,
    List<Device>? devices,
  }) : devices = devices ?? [];

  int get numberOfLightDevices {
    return devices.whereType<LightDevice>().length;
  }

  int get numberOfFanDevices {
    return devices.whereType<FanDevice>().length;
  }

  void rename(String name) {
    if (name.isEmpty) return;
    this.name = name;
  }

  void addDevice(Device device) {
    if (devices.any((d) => d.name == device.name)) {
      throw Exception('Device name already exists');
    }
    devices.add(device);
  }

  void removeDevice(Device device) {
    devices.remove(device);
  }

  void updateRoomDevice(Device newDevice) {
    int index = devices.indexWhere((device) => device.id == newDevice.id);
    if (index != -1) {
      devices[index] = newDevice;
    }
  }

  @override
  bool operator ==(Object other) => other is Room && other.name == name;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return 'Room $name';
  }
}
