enum DeviceType { light, fan }

abstract class Device {
  final int id;
  String name;
  DeviceType type;
  bool isOn = false;

  Device({
    required this.id,
    required this.name,
    required this.type,
  });

  void rename(String name) {
    if (name.isEmpty) return;
    this.name = name;
  }

  double get value;
  void setValue(double value);

  @override
  bool operator ==(Object other) =>
      other is Device && other.name == name && other.type == type;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return '[$type, $name]';
  }
}
