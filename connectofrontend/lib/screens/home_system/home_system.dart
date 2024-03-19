import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/home_system/home_env_control.dart';
import 'package:connectofrontend/widgets/home_system/home_system_header_row.dart';
import 'package:connectofrontend/widgets/home_system/home_system_rooms_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSystemScreen extends StatefulWidget {
  const HomeSystemScreen({super.key});

  @override
  State<HomeSystemScreen> createState() => HomeSystemScreenState();
}

class HomeSystemScreenState extends State<HomeSystemScreen> {
  @override
  Widget build(BuildContext context) {
    List<Room> rooms = Provider.of<HomeSystemState>(context).rooms;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 50, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Home System Dashboard',
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
                // Home Environmental Conditions Control section
                HomeEnvironmentalConditionsControlTab(rooms: rooms),
                const SizedBox(height: 25),
                HomeSystemHeaderRow(parentScreen: Screen.homeSystem),
                const HomeSystemRoomsTab(parentScreen: Screen.homeSystem),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
