import 'package:connectofrontend/models/external_app.dart';
import 'package:connectofrontend/screens/external_apps/app_selection.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';

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
      flutterIcon: Icons.apps,
    ),
    const ExternalApp(
      name: 'Instagram',
      packageName: 'com.instagram.android',
      flutterIcon: Icons.apps,
    ),
    const ExternalApp(
      name: 'Maps',
      packageName: 'com.android.maps',
      flutterIcon: Icons.apps,
    ),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
  ];

  /// Replaces first ExternalApp in list whose packageName is empty
  handleAppSelected(AppInfo app) {
    setState(() {
      final index = externalApps
          .indexWhere((externalApp) => externalApp.packageName.isEmpty);
      externalApps[index] = ExternalApp.fromAppInfo(app);
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
        const SizedBox(height: 32.0),
        SizedBox(
          height: 152,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: externalApps.length,
            itemBuilder: (context, index) {
              ExternalApp app = externalApps[index];
              return GestureDetector(
                onTap: () async {
                  if (app.packageName.isNotEmpty) {
                    await LaunchApp.openApp(
                      androidPackageName: app.packageName,
                      openStore: false,
                    );
                  } else {
                    if (!context.mounted) return;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AppSelectionScreen(
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
                      (app.icon != null)
                          ? Image.memory(
                              app.icon!,
                              height: 50,
                              width: 50,
                            )
                          : Icon(
                              app.flutterIcon,
                              size: 48,
                            ),
                      const SizedBox(height: 8),
                      Text(
                        externalApps[index].name,
                        style: const TextStyle(
                          fontSize: 16,
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
