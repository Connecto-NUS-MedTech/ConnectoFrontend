import 'package:connectofrontend/models/external_app.dart';
import 'package:connectofrontend/screens/external_apps/app_selection.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class ExternalApplicationsRow extends StatefulWidget {
  const ExternalApplicationsRow({super.key});

  @override
  State<ExternalApplicationsRow> createState() =>
      _ExternalApplicationsRowState();
}

class _ExternalApplicationsRowState extends State<ExternalApplicationsRow> {
  final List<ExternalApp> externalApps = [
    const ExternalApp(
      name: 'Chrome',
      packageName: 'com.android.chrome',
      icon: Icons.apps,
    ),
    const ExternalApp(
      name: 'Instagram',
      packageName: 'com.instagram.android',
      icon: Icons.apps,
    ),
    const ExternalApp(
      name: 'Maps',
      packageName: 'com.android.maps',
      icon: Icons.apps,
    ),
    const ExternalApp(name: 'Add App', packageName: '', icon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', icon: Icons.add),
  ];

  /// Replaces first ExternalApp in list whose packageName is empty
  handleAppSelected(Application app) {
    setState(() {
      final index = externalApps
          .indexWhere((externalApp) => externalApp.packageName.isEmpty);
      externalApps[index] = ExternalApp(
        name: app.appName,
        packageName: app.packageName,
        icon: Icons.apps,
      );
    });
  }

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
              return GestureDetector(
                onTap: () async {
                  if (externalApps[index].packageName.isNotEmpty) {
                    await LaunchApp.openApp(
                      androidPackageName: externalApps[index].packageName,
                      openStore: false,
                    );
                  } else {
                    List<Application> apps =
                        await DeviceApps.getInstalledApplications();
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppSelectionScreen(
                          apps: apps,
                          onAppSelected: handleAppSelected,
                        ),
                      ),
                    );
                  }
                },
                child: Container(
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
                      Icon(
                        externalApps[index].icon,
                        size: 48, // Adjust the size of the icon
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
