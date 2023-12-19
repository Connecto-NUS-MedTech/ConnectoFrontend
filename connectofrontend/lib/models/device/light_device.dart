import 'package:connectofrontend/models/device/device.dart';

class LightDevice extends Device {
  double brightness;

  LightDevice(String name, double brightness)
      : brightness = brightness.clamp(0.0, 1.0),
        super(name: name, type: DeviceType.light);

  setBrightness(double brightness) {
    this.brightness = brightness.clamp(0.0, 1.0);
  }
}
