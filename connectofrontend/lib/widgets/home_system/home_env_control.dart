import 'package:flutter/material.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/home_system/custom_switch.dart';
import 'package:connectofrontend/widgets/home_system/master_card.dart';

class HomeEnvironmentalConditionsControlTab extends StatefulWidget {
  final List<Room> rooms;
  final Function(String, SwitchStatus) onChanged;

  const HomeEnvironmentalConditionsControlTab({
    super.key,
    required this.rooms,
    required this.onChanged,
  });

  @override
  State<HomeEnvironmentalConditionsControlTab> createState() {
    return _HomeEnvironmentalConditionsControlTab();
  }
}

class _HomeEnvironmentalConditionsControlTab
    extends State<HomeEnvironmentalConditionsControlTab> {
  // update main dashboard when main switch status changes
  void updateMainDB(String cardText, SwitchStatus newStatus) {
    widget.onChanged(cardText, newStatus);
  }

  @override
  Widget build(BuildContext context) {
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
                ),
              ),
              const SizedBox(
                width: 32,
              ),
              Expanded(
                child: MasterCard(
                  cardText: 'ALL FANS',
                  callback: updateMainDB,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
