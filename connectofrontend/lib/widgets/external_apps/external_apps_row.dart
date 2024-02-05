import 'package:connectofrontend/models/external_app.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';

class ExternalApplicationsRow extends StatelessWidget {
  const ExternalApplicationsRow({super.key});

  // Replace this with your actual list of apps
  final List<ExternalApp> externalApps = const [
    ExternalApp(name: 'Chrome', icon: Icons.apps),
    ExternalApp(name: 'Instagram', icon: Icons.apps),
    ExternalApp(name: 'Maps', icon: Icons.apps),
    ExternalApp(name: 'Add App', icon: Icons.add),
    ExternalApp(name: 'Add App', icon: Icons.add),

    // Add more apps as needed
  ];

  @override
  Widget build(BuildContext context) {
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
}
