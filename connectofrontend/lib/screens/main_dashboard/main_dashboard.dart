import 'package:connectofrontend/models/room.dart';
import 'package:connectofrontend/providers/home_system_state.dart';
import 'package:connectofrontend/widgets/home_system/home_env_control.dart';
import 'package:connectofrontend/widgets/home_system/home_system_header_row.dart';
import 'package:connectofrontend/widgets/home_system/home_system_rooms_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:external_app_launcher/external_app_launcher.dart';

class AppInfo {
  final String name;
  final IconData icon;

  AppInfo({required this.name, required this.icon});
}

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => MainDashboardScreenState();
}

class MainDashboardScreenState extends State<MainDashboardScreen> {

  Widget buildExternalApplications() {
    // Replace this with your actual list of apps
    List<AppInfo> externalApps = [
      AppInfo(name: 'Chrome', icon: Icons.apps),
      AppInfo(name: 'Instagram', icon: Icons.apps),
      AppInfo(name: 'Maps', icon: Icons.apps),
      AppInfo(name: 'Add App', icon: Icons.add),
      AppInfo(name: 'Add App', icon: Icons.add),

      // Add more apps as needed
    ];

    return Container(
      height: 125,
      color: Colors.grey,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: externalApps.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                IconButton(
                  icon: Icon(
                    externalApps[index].icon,
                    size: 48, // Adjust the size of the icon
                  ),
                  onPressed: () async {
                    await LaunchApp.openApp(
                      androidPackageName: 'com.android.chrome',
                      openStore: false,
                    );
                    // Handle app button click
                    // You can navigate to the app or perform any other action
                  },
                ),
                const SizedBox(
                  height: 8, // Add spacing between the icon and text
                ),
                Text(
                  externalApps[index].name,
                  style: const TextStyle(
                    fontSize: 16, // Adjust the size of the text
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

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
                // Replace the Container with custom widget
                buildExternalApplications(),
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
