import 'package:connectofrontend/models/device/device.dart';

class FanDevice extends Device {
  double speed;

  FanDevice({required id, required String name, double speed = 0.0})
      : speed = speed.clamp(0.0, 1.0),
        super(id: id, name: name, type: DeviceType.fan);

  @override
  // double get value => speed;
  double getValue() {
    return speed;
  }

  @override
  setValue(double value) {
    speed = value.clamp(0.0, 1.0);
  }
}
