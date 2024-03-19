import 'package:flutter/material.dart';
// import 'package:device_apps/device_apps.dart';
import 'package:connectofrontend/models/external_app.dart';
import 'package:connectofrontend/screens/external_apps/app_selection.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:device_apps/device_apps.dart';
import 'package:installed_apps/app_info.dart';

class ExternalAppsScreen extends StatefulWidget {
  // final List<Application> apps;

  const ExternalAppsScreen({
    super.key,
    // required this.apps,
  });

  @override
  State<ExternalAppsScreen> createState() => ExternalAppsScreenState();
}

class ExternalAppsScreenState extends State<ExternalAppsScreen> {
  // TODO: Use actual apps the user has
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
    const ExternalApp(
      name: 'Adobe Illustrator',
      packageName: '',
      flutterIcon: Icons.add,
    ),
    const ExternalApp(
      name: 'Adobe Photoshop',
      packageName: '',
      flutterIcon: Icons.add,
    ),
    const ExternalApp(
      name: 'Mobile Legends',
      packageName: '',
      flutterIcon: Icons.add,
    ),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
    const ExternalApp(name: 'Add App', packageName: '', flutterIcon: Icons.add),
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
    const Color primaryColor = Color(0xFF455A64);

    final deleteAppsButton = Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
      child: const Row(
        children: [
          Icon(
            Icons.delete_rounded,
            color: Color(0xFFFFFFFF),
          ),
          SizedBox(width: 8),
          Text(
            'Delete App',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFFFFFFFF),
            ),
          ),
        ],
      ),
    );

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 50, 16, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Text(
              //   'External Apps',
              //   style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
              // ),
              // const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'External Apps',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
                  ),
                  deleteAppsButton,
                ],
              ),
              const SizedBox(
                height: 32.0,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    mainAxisSpacing: 32.0,
                    crossAxisSpacing: 32.0,
                    childAspectRatio: 1.5, // width:height
                  ),
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
                            (externalApps[index].icon != null)
                                ? Image.memory(
                                    externalApps[index].icon!,
                                    height: 50,
                                    width: 50,
                                  )
                                : Icon(
                                    externalApps[index].flutterIcon,
                                    size: 40,
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
          ),
        ),
      ),
    );
  }
}
