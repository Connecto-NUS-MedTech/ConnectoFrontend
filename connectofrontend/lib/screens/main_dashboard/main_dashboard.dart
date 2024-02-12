import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/external_apps/external_apps_row.dart';
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
                const Text(
                  'Main Dashboard',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                // change name to user's name
                const Text(
                  'Welcome Home, Doraemon!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 24),
                const ExternalApplicationsRow(),
                const SizedBox(height: 40),
                // Home Environmental Conditions Control section
                HomeEnvironmentalConditionsControlTab(
                  rooms: bookmarkedRooms,
                ),
                const SizedBox(height: 40),
                HomeSystemHeaderRow(parentScreen: Screen.mainDashboard),
                const HomeSystemRoomsTab(parentScreen: Screen.mainDashboard),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
