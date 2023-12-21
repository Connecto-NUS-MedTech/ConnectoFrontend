import 'package:connectofrontend/models/device/device.dart';

class FanDevice extends Device {
  double speed;

  FanDevice({required String name, double speed = 0.0})
      : speed = speed.clamp(0.0, 1.0),
        super(name: name, type: DeviceType.light);

  setSpeed(double speed) {
    this.speed = speed.clamp(0.0, 1.0);
  }
}
