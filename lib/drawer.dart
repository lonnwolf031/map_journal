import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'routes/routes.dart';

Widget createDrawer(BuildContext context) {
  return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Theme.of(context).canvasColor,
            child: DrawerHeader(
              child: Text(
                'Navigation Drawer',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Map'),
              onTap: () {
                Navigator.pushReplacementNamed(context, routes.maps);
              }),
          ListTile(
              leading: Icon(Icons.pie_chart),
              title: Text('Reports'),
              onTap: () {
                Navigator.pushReplacementNamed(context, routes.reports);
              }),
          ListTile(
              leading: Icon(Icons.pie_chart),
              title: Text('Permissions'),
              onTap: () {
                Navigator.pushReplacementNamed(context, routes.permissions);
              }),
        ],
      ));
}
