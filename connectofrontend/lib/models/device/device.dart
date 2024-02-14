enum DeviceType { light, fan }

abstract class Device implements Comparable<Device> {
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

  // Connects switch and slider
  double get value;

  void setValue(double value);

  @override
  bool operator ==(Object other) =>
      other is Device && other.name == name && other.type == type;

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() {
    return '[$type, $name, $isOn]';
  }
  
  @override
  /// Sort Fan before Light, then sort by name
  int compareTo(Device other) {
    if (type == DeviceType.fan && other.type == DeviceType.light) {
      return -1;
    } else if (type == DeviceType.light && other.type == DeviceType.fan) {
      return 1;
    } else {
      return name.compareTo(other.name);
    }
  }
}
