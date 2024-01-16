import 'package:connectofrontend/models/device/device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/widgets/home_system/custom_switch.dart';
import 'package:connectofrontend/widgets/home_system/device/device_settings_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeviceTab extends StatefulWidget {
  final Device device;
  final Function(Device) onDeviceUpdated;
  final Function(Device) onDeviceDeleted;

  const DeviceTab({
    super.key,
    required this.device,
    required this.onDeviceUpdated,
    required this.onDeviceDeleted,
  });

  @override
  State<DeviceTab> createState() => _DeviceTabState();
}

class _DeviceTabState extends State<DeviceTab> {
  // Change status of device when switch is toggled
  void updateSwitch(SwitchStatus status) {
    setState(() {
      widget.device.isOn = status == SwitchStatus.on;
    });

    // OR once the state changes, go to main dashboard and trigger a function that checks if all devices are off
    // pass the change to main dashboard
  }

  @override
  Widget build(BuildContext context) {
    String deviceIcon = widget.device is LightDevice
        ? 'assets/icons/lightbulb.svg'
        : 'assets/icons/fan.svg';

    String deviceFeature =
        widget.device is LightDevice ? 'Brightness' : 'Fan Speed';

    double devicePercentage = widget.device.value;

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 24, 32, 24),
        child: Row(
          children: [
            DeviceSettingsMenu(
              device: widget.device,
              onDeviceUpdated: widget.onDeviceUpdated,
              onDeviceDeleted: widget.onDeviceDeleted,
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            deviceIcon,
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            widget.device.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      CustomSwitch(
                        value: widget.device.isOn
                            ? SwitchStatus.on
                            : SwitchStatus.off,
                        onChanged: updateSwitch,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        deviceFeature,
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        '${(devicePercentage * 100).round()}%',
                        style: const TextStyle(fontSize: 16),
                      ),
                      // Text(widget.device is LightDevice ? widget.device. : )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Slider(
                    value: widget.device.value,
                    min: 0,
                    max: 1,
                    // TODO: Persist the new value, communicate with IoT device
                    onChanged: (newValue) {
                      setState(() {
                        widget.device.setValue(newValue);
                      });
                    },
                    activeColor: const Color(0xFF455A64),
                    inactiveColor: const Color(0xFFCFD8DC),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
