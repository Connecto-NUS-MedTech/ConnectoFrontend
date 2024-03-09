import 'package:connectofrontend/screens/home_system/home_system.dart';
import 'package:connectofrontend/screens/main_dashboard/main_dashboard.dart';
import 'package:connectofrontend/screens/external_apps/external_apps.dart';
import 'package:flutter/material.dart';

/// Wrapper widget for all screens (besides the authentication and onboarding screens)
class ScreenWrapper extends StatefulWidget {
  const ScreenWrapper({super.key});

  @override
  State<ScreenWrapper> createState() => _ScreenWrapperState();
}

class _ScreenWrapperState extends State<ScreenWrapper> {
  int _selectedPageIndex = 0;
  final NavigationRailLabelType _labelType = NavigationRailLabelType.all;
  final double _groupAlignment = -1.0; // -1, 0, or 1 for top, center, or bottom

  final List<NavigationRailDestination> _navBarIcons = [
    const NavigationRailDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_filled),
      label: Text('Main'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.router_outlined),
      selectedIcon: Icon(Icons.router),
      label: Text('Home System'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.chat_bubble_outline),
      selectedIcon: Icon(Icons.chat_bubble),
      label: Text('Chat'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings),
      label: Text('Settings'),
    ),
    const NavigationRailDestination(
      icon: Icon(Icons.apps_outlined),
      selectedIcon: Icon(Icons.apps),
      label: Text('Apps'),
    ),
  ];

  final List<Widget> _pages = [
    const MainDashboardScreen(),
    const HomeSystemScreen(),
    const Text('Chat'),
    const Text('Settings'),
    const ExternalAppsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          NavigationRail(
            backgroundColor: const Color.fromRGBO(0x45, 0x5A, 0x64, 1),
            selectedIndex: _selectedPageIndex,
            groupAlignment: _groupAlignment,
            selectedIconTheme: const IconThemeData(color: Colors.white),
            selectedLabelTextStyle: const TextStyle(color: Colors.white),
            unselectedIconTheme: const IconThemeData(color: Colors.white),
            unselectedLabelTextStyle: const TextStyle(color: Colors.white),
            onDestinationSelected: (int index) {
              setState(() {
                _selectedPageIndex = index;
              });
            },
            labelType: _labelType,
            destinations: _navBarIcons,
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Flexible(
            child: _pages[_selectedPageIndex],
          ),
        ],
      ),
    );
  }
}
