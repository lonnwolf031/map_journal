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

  late GoogleMapController mapController;
  Set<Marker> _markers = Set();
  final LatLng _center = const LatLng(45.521563, -122.677433);

  int _numMarker = 0;

  // reference to our single class that manages the database
  final dbHelper = DatabaseHelper.instance;

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
      ///SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
    }
  }
 String numMarkerCounterToId() {
    _numMarker = _numMarker++;
    return _numMarker.toString();
 }

 Marker _newMarker() {
    MarkerId _mID = MarkerId(numMarkerCounterToId());
    Marker _marker = new Marker(markerId: _mID, position: currentlatlng); //, onTap: _onMarkerTap(_mID)
    return _marker;
 }

 InfoWindow _newInfoWindow(MarkerId _mId) {
    InfoWindow _nwInfoWIndow = InfoWindow(title: "test", onTap: gotoscreenwithinfo);
    return _nwInfoWIndow;
 }

  void onMarkerTapped(Marker marker) {

  }

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
            onLongPress: (LatLng latLng) {
              _markers.add(_newMarker());
              // go to window to add info and add to sqflite
              setState(() {});
          },

            markers: Set<Marker>.of(_markers),
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
