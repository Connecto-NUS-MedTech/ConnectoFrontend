import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';
import 'package:installed_apps/installed_apps.dart';

class AppSelectionScreen extends StatefulWidget {
  final Function(AppInfo) onAppSelected;

  const AppSelectionScreen({
    super.key,
    required this.onAppSelected,
  });

  @override
  State<AppSelectionScreen> createState() => AppSelectionScreenState();
}

class AppSelectionScreenState extends State<AppSelectionScreen> {
  Future<List<AppInfo>>? apps;

  Future<List<AppInfo>> getApps() async {
    List<AppInfo> res = await InstalledApps.getInstalledApps(true, true, '');
    return res;
  }

  @override
  void initState() {
    super.initState();
    apps = getApps();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add app to MainDashboard'),
      ),
      body: FutureBuilder<List<AppInfo>>(
        future: apps,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<AppInfo> externalApps = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 5,
                ),
                itemCount: externalApps.length,
                itemBuilder: (context, index) {
                  AppInfo app = externalApps[index];
                  return Center(
                    child: GestureDetector(
                      onTap: () {
                        widget.onAppSelected(app);
                        Navigator.of(context).pop();
                      },
                      child: Column(
                        children: [
                          (app.icon != null)
                              ? Image.memory(
                                  app.icon!,
                                  height: 50,
                                  width: 50,
                                )
                              : const Icon(Icons.apps),
                          Text(app.name ?? ''),
                        ],
                      ),
                    ),
                    // ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
