import 'package:connectofrontend/models/device/device.dart';

class Room {
  String name;
  List<Device> devices;

  Room({
    required this.name,
    required this.devices,
  });

  void addDevice(Device device) {
    if (devices.any((d) => d.name == device.name)) {
      throw Exception('Device name already exists');
    }
    devices.add(device);
  }

  void removeDevice(Device device) {
    devices.remove(device);
  }

  void updateRoomDevices(List<Device> devices) {
    this.devices = devices;
  }

  @override
  bool operator ==(Object other) => other is Room && other.name == name;

  @override
  int get hashCode => name.hashCode;
}
