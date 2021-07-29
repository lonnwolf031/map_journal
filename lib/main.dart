import 'package:flutter/material.dart';
import 'routes/routes.dart';
import 'reportsview.dart';
import 'mapview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Drawer Demo',
      home: MapView(),
      routes: {
        routes.maps: (context) => MapView(),
        routes.reports: (context) => ReportsView(),
      },
    );
  }
}

