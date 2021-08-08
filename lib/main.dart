import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'reportsview.dart';
import 'mapview.dart';
import 'permissionview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final int itemId = 0;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Drawer Demo',
      home: MapView(),
      routes: {
        routes.maps: (context) => MapView(),
        routes.reports: (context) => ReportsView(),
        routes.permissions: (context) => PermissionView(),
      },
    );
  }
}

