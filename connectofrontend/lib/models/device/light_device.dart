import 'package:connectofrontend/models/device/device.dart';

class LightDevice extends Device {
  double brightness;

  LightDevice({required id, required String name, double brightness = 0.0})
      : brightness = brightness.clamp(0.0, 1.0),
        super(id: id, name: name, type: DeviceType.light);

  @override
  double get value => brightness;

  @override
  setValue(double value) {
    brightness = value.clamp(0.0, 1.0);
    isOn = brightness > 0;
  }
}
