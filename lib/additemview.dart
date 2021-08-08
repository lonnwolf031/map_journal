import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sqflite/sqflite.dart';
import 'database_helper.dart';
import 'drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'item.dart';

class AddItemView extends StatefulWidget {
  static const String routeName = '/additem';
  @override
  _AddItemViewState createState() => _AddItemViewState();

}

class _AddItemViewState extends State<AddItemView> {
  GlobalKey<ScaffoldState> _key = GlobalKey();
  final _formKey = GlobalKey<FormState>();
  final formController = TextEditingController();
  String _title = "";
  String _description = "";

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    formController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: formController,
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter a title';
              }
              return null;
            },
            onChanged: (newVal) {
              _title = newVal;
            },
          ),
          TextFormField(
            controller: formController,
            // The validator receives the text that the user has entered.
            validator: (value) {
              bool isValid = RegExp(r"^[A-Za-z0-9]{1,20}$").hasMatch(value!);
              if (value == null || value.isEmpty) {
                return 'Please enter a description';
              }
              else if (!isValid) {
                return 'Please enter title with a maximum of 20 characters and/or numbers';
              }
              return null;
            },
            onChanged: (newVal) {
              _description = newVal;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState!.validate()) {
                  //do something with info

                  // If the form is valid, display a snackbar. In the real world,
                  // you'd often call a server or save the information in a database.
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Saved data successfully')),

                  );
                  //navigate back to map
                }
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

}
