import 'package:flutter/material.dart';
import 'package:connectofrontend/widgets/home_system/custom_switch.dart';

class MasterCard extends StatefulWidget {
  final String cardText;
  final Function(String, SwitchStatus) callback;
  final SwitchStatus newStatus;
  final String newDevice;

  const MasterCard({
    super.key,
    required this.cardText,
    required this.callback,
    required this.newStatus,
    required this.newDevice,
  });

  @override
  State<MasterCard> createState() {
    return _MasterCardState();
  }
}

class _MasterCardState extends State<MasterCard> {
  SwitchStatus cardState = SwitchStatus.off;
  // bool toUpdateSwitch = false;

  SwitchStatus determineCardState() {
    String deviceType = widget.newDevice == 'Fan' ? 'ALL FANS' : 'ALL LIGHTS';

    if (deviceType == widget.cardText &&
        widget.newStatus != SwitchStatus.neither) {
      cardState = widget.newStatus;
      return widget.newStatus;
    } else if (deviceType == widget.cardText &&
        widget.newStatus == SwitchStatus.neither) {
      cardState = widget.newStatus;
      return SwitchStatus.neither;
    }
    return cardState;
  }

  void updateSwitch(SwitchStatus status) {
    setState(() {
      cardState = status;
    });
    widget.callback(widget.cardText, status);
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
