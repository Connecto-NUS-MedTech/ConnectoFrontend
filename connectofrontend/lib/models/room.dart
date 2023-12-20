import 'package:connectofrontend/models/device.dart';

class Room {
  String name;
  List<Device> devices;

  Room({
    required this.name,
    required this.devices,
  });
}
