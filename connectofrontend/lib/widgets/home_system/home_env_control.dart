import 'package:connectofrontend/models/device/fan_device.dart';
import 'package:connectofrontend/models/device/light_device.dart';
import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/widgets/home_system/master_card.dart';
import 'package:flutter/material.dart';

class HomeEnvironmentalConditionsControlTab extends StatefulWidget {
  final List<Room> rooms;

  const HomeEnvironmentalConditionsControlTab({
    super.key,
    required this.rooms,
  });

  @override
  State<HomeEnvironmentalConditionsControlTab> createState() {
    return _HomeEnvironmentalConditionsControlTab();
  }
}

class _HomeEnvironmentalConditionsControlTab
    extends State<HomeEnvironmentalConditionsControlTab> {

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Home Environmental Conditions Control',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
          child: Row(
            children: [
              Expanded(
                child: MasterCard(
                  deviceType: LightDevice,
                ),
              ),
              SizedBox(width: 32),
              Expanded(
                child: MasterCard(
                  deviceType: FanDevice,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
