import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/home_system/home_env_control.dart';
import 'package:connectofrontend/widgets/home_system/home_system_header_row.dart';
import 'package:connectofrontend/widgets/home_system/home_system_rooms_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => MainDashboardScreenState();
}

class MainDashboardScreenState extends State<MainDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    List<Room> bookmarkedRooms =
        Provider.of<HomeSystemState>(context).bookmarkedRooms;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TODO: Replace Container with custom widget
                Container(
                  height: 125,
                  color: Colors.grey,
                  child: const Row(
                    children: [
                      Text('ExternalApplications widget goes here'),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // Home Environmental Conditions Control section
                HomeEnvironmentalConditionsControlTab(
                  rooms: bookmarkedRooms,
                ),
                const SizedBox(height: 25),
                const HomeSystemHeaderRow(),
                const HomeSystemRoomsTab(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
