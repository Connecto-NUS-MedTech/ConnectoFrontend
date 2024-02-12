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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'External Applications',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
        ),
        const SizedBox(
          height: 32.0,
        ),
        SizedBox(
          height: 152,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: externalApps.length,
            itemBuilder: (context, index) {
              return Container(
                width: 172,
                margin: const EdgeInsets.only(right: 32),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
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
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
