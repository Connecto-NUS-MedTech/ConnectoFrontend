import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:installed_apps/app_info.dart';

class ExternalApp {
  final String name;
  final String packageName;
  final IconData? flutterIcon;  // Use this for placeholder flutter icons
  final Uint8List? icon;  // This is for actual icons (Android only)

  const ExternalApp({
    required this.name,
    required this.packageName,
    this.flutterIcon,
    this.icon,
  });

  factory ExternalApp.fromAppInfo(AppInfo appInfo) {
    return ExternalApp(
      name: appInfo.name ?? '',
      icon: appInfo.icon,
      packageName: appInfo.packageName ?? '',
    );
  }
}
