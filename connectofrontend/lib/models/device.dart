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

class LightDevice extends Device {
  double brightness;

  LightDevice(name, double brightness)
      : brightness = brightness.clamp(0.0, 1.0),
        super(name: name, type: DeviceType.light);

  setBrightness(double brightness) {
    this.brightness = brightness.clamp(0.0, 1.0);
  }
}

class FanDevice extends Device {
  double speed;

  FanDevice(name, double speed)
      : speed = speed.clamp(0.0, 1.0),
        super(name: name, type: DeviceType.light);

  setSpeed(double speed) {
    this.speed = speed.clamp(0.0, 1.0);
  }
}
