import 'package:flutter/material.dart';
import 'drawer.dart';

class ReportsView extends StatelessWidget {
  static const String routeName = '/reports';



  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('Reports'),
              backgroundColor: Colors.green[700],
              centerTitle: true,
            ),
            drawer: createDrawer(context)
        ));
  }
}