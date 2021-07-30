import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';

class MapView extends StatefulWidget {
  static const String routeName = '/mapview';

  @override
  _MyAppState createState() => _MyAppState();

}

class _MyAppState extends State<MapView> {

  @override
  void initState() {
    runPermissions();
    super.initState();
  }

  runPermissions() async {
    if (await Permission.location.request().isGranted) {
      ///Navigator.push(context, MaterialPageRoute(builder: (context) => NextPage()));
    } else  {
      /// exit app
      SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
  }
  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

  /*
  var status = await Permission.camera.status;
  if (status.isDenied) {
  // We didn't ask for permission yet or the permission has been denied before but not permanently.
  }
*/
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: createDrawer(context),
        appBar: AppBar(
          title: Text('Maps Journal'),
          backgroundColor: Colors.green[700],
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
    );
  }

  // Button onPressed methods

  void _insert() async {
    // row to insert
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : 'Bob',
      DatabaseHelper.columnAge  : 23
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  void _query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach(print);
  }

  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Mary',
      DatabaseHelper.columnAge  : 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id!);
    print('deleted $rowsDeleted row(s): row $id');
  }
}
