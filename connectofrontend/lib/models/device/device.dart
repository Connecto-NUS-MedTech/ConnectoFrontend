enum DeviceType { light, fan }

abstract class Device {
  String name;
  DeviceType type;
  bool isOn = false;

  Device({
    required this.name,
    required this.type,
  });
}
