import 'package:flutter/material.dart';
import 'package:connectofrontend/widgets/home_system/custom_switch.dart';

class MasterCard extends StatefulWidget {
  final String cardText;
  final Function(String, SwitchStatus) callback;
  final SwitchStatus newStatus;
  final String newDevice;
  // final Function(String, SwitchStatus) updateDeviceCallback;

  const MasterCard({
    super.key,
    required this.cardText,
    required this.callback,
    required this.newStatus,
    required this.newDevice,
    // required this.updateDeviceCallback,
  });

  @override
  State<MasterCard> createState() {
    return _MasterCardState();
  }
}

class _MasterCardState extends State<MasterCard> {
  SwitchStatus cardState = SwitchStatus.neither;
  bool toUpdateSwitch = false;

  bool toggled = false;

  SwitchStatus determineCardState() {
    String deviceType = widget.newDevice == 'Fan' ? 'ALL FANS' : 'ALL LIGHTS';

    print(
      'device type in cardstate: $deviceType, new device is ${widget.newDevice}',
    );

    if (toUpdateSwitch) {
      toUpdateSwitch = false;
      // print('set to update switch to : $toUpdateSwitch');

      return cardState;
    } else {
      // print('NO TOGGLE');
      // ensure correct Switch is selected
      if (deviceType == widget.cardText &&
          widget.newStatus != SwitchStatus.neither) {
        // print(
        //   '1: ${widget.cardText} status: ${widget.newStatus} ----------------------',
        // );
        cardState = widget.newStatus;
        // previous device was a lightdevice butwhen you toggleFan device, it affects all Lights
        return widget.newStatus;
      } else if (deviceType == widget.cardText &&
          widget.newStatus == SwitchStatus.neither) {
        // print('deviceType is: $deviceType & cardText is ${widget.cardText}');
        // print(
        //   '2 neither: ${widget.cardText} status: ${widget.newStatus} f----------------------',
        // );
        cardState = widget.newStatus;
        return SwitchStatus.neither;
      }
      // print(
      //   '3: ${widget.cardText} status: $cardState ----------------------',
      // );
      return cardState;
    }
  }

// manual clicking of any switch
// ISSUE: When you manually click Light, if you previous toggled the tiny LightDevice,
// widget.newDevice = LightDevice. Now, in determineCardState(), even if you click on big FanDevice
// CS, when it renders big LightDevice card, it will say == (cond 1 or 2)
// NOTE: if it's a manual click of big switch, we only change value of affected switch
  void updateSwitch(SwitchStatus status) {
    setState(() {
      cardState = status;
      // widget.newDevice = 'None';
      print('set card state in update switch');
      print('IN UPDATE SWITCH');
    });
    toUpdateSwitch = true;
    print('new device is ${widget.newDevice}');
    widget.callback(widget.cardText, status);
    // update the parent with this device's new status
    // widget.updateDeviceCallback(widget.cardText, status);

    // print('updateSwitch for ${widget.cardText}: $cardState');
  }

  @override
  Widget build(BuildContext context) {
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
              widget.cardText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 56,
            ),
            CustomSwitch(
              value: determineCardState(),
              onChanged: updateSwitch,
            ),
          ],
        ),
      ),
    );
  }
}
