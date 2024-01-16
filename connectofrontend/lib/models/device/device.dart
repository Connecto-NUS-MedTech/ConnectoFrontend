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

  // Connects switch and slider
  // TODO: Check - when initial value = 0 (manually dragged slider to 0)
  // and afterwards switch is turned on, set value = 0.5
  double get value {
    if (!isOn) {
      return 0;
    } else if (isOn && getValue() == 0) {
      return 0.5;
    }
    return getValue();
  }

  double getValue();

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
