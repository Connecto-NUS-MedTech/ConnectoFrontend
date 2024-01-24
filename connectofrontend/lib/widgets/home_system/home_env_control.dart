import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/home_system/custom_switch.dart';
import 'package:connectofrontend/widgets/home_system/master_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

typedef MyBuilder = void Function(
  BuildContext context,
  void Function(String, SwitchStatus) methodFromChild,
);

class HomeEnvironmentalConditionsControlTab extends StatefulWidget {
  final List<Room> rooms;
  final SwitchStatus newStatus;
  final String newDevice;
  final MyBuilder builder;

  const HomeEnvironmentalConditionsControlTab({
    super.key,
    required this.rooms,
    required this.newStatus,
    required this.newDevice,
    required this.builder,
  });

  @override
  State<HomeEnvironmentalConditionsControlTab> createState() {
    return _HomeEnvironmentalConditionsControlTab();
  }
}

class _HomeEnvironmentalConditionsControlTab
    extends State<HomeEnvironmentalConditionsControlTab> {
  // random values
  String selectedDevice = 'None';
  SwitchStatus status = SwitchStatus.off;

  @override
  void initState() {
    super.initState();
    selectedDevice = widget.newDevice;
    status = widget.newStatus;
  }

  void childMethod(String deviceType, SwitchStatus deviceStatus) {
    setState(() {
      selectedDevice = deviceType;
      status = deviceStatus;
    });
  }

  @override
  Widget build(BuildContext context) {
    widget.builder.call(context, childMethod);

    // update main dashboard when main switch status changes
    void updateMainDB(String cardText, SwitchStatus newStatus) {
      var homeSystemState =
          Provider.of<HomeSystemState>(context, listen: false);
      homeSystemState.toggleAllDevices(cardText, newStatus);

      setState(() {
        selectedDevice = cardText == 'ALL FANS' ? 'Fan' : 'Light';
        status = newStatus;
      });
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Home Environmental Conditions Control',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: Row(
            children: [
              Expanded(
                child: MasterCard(
                  cardText: 'ALL LIGHTS',
                  callback: updateMainDB,
                  newStatus: status,
                  newDevice: selectedDevice,
                ),
              ),
              const SizedBox(
                width: 32,
              ),
              Expanded(
                child: MasterCard(
                  cardText: 'ALL FANS',
                  callback: updateMainDB,
                  newStatus: status,
                  newDevice: selectedDevice,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
