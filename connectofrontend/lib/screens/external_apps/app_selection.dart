import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';

class AppSelectionScreen extends StatefulWidget {
  final List<Application> apps;
  final Function(Application) onAppSelected;

  const AppSelectionScreen({
    super.key,
    required this.apps,
    required this.onAppSelected,
  });

  @override
  State<AppSelectionScreen> createState() => AppSelectionScreenState();
}

class AppSelectionScreenState extends State<AppSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add app to MainDashboard'),
      ),
      body: GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
        itemCount: widget.apps.length,
        itemBuilder: (context, index) {
          return Center(
            child: SizedBox(
              height: 30,
              child: GestureDetector(
                onTap: () {
                  widget.onAppSelected(widget.apps[index]);
                  Navigator.of(context).pop();
                },
                child: Text(
                  widget.apps[index].appName,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
