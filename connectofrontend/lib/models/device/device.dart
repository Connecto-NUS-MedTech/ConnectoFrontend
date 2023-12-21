enum DeviceType { light, fan }

abstract class Device {
  String name;
  DeviceType type;
  bool isOn = false;

  Device({
    required this.name,
    required this.type,
  });

  @override
  bool operator ==(Object other) =>
      other is Device && other.name == name && other.type == type;

  @override
  int get hashCode => name.hashCode;
}
