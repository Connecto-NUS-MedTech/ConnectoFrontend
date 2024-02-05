import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:flutter/material.dart';
import 'package:connectofrontend/widgets/home_system/custom_switch.dart';
import 'package:provider/provider.dart';

class MasterCard extends StatefulWidget {
  final Type deviceType;

  const MasterCard({
    super.key,
    required this.deviceType,
  });

  @override
  State<MasterCard> createState() {
    return _MasterCardState();
  }
}

class _MasterCardState extends State<MasterCard> {
  @override
  Widget build(BuildContext context) {
    var homeSystemState = Provider.of<HomeSystemState>(context);

    SwitchStatus getSwitchStatus() {
      if (widget.deviceType == LightDevice) {
        return homeSystemState.numLightsOn == homeSystemState.totalLightDevices
            ? SwitchStatus.on
            : homeSystemState.numLightsOn == 0
                ? SwitchStatus.off
                : SwitchStatus.neither;
      } else {
        return homeSystemState.numFansOn == homeSystemState.totalFanDevices
            ? SwitchStatus.on
            : homeSystemState.numFansOn == 0
                ? SwitchStatus.off
                : SwitchStatus.neither;
      }
    }

    /// `status` should only be on or off
    void setMasterSwitchStatus(SwitchStatus status) {
      homeSystemState.setAllDevices(
        widget.deviceType,
        status == SwitchStatus.on,
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(1, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.deviceType == LightDevice ? 'ALL LIGHTS' : 'ALL FANS',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 56),
            CustomSwitch(
              value: getSwitchStatus(),
              onChanged: setMasterSwitchStatus,
            ),
          ],
        ),
      ),
    );
  }
}
