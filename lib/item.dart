import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:sqflite/sqflite.dart';

class Item {
  int id;
  String title;
  LatLng ltlngLocation;
  String description;
  Item.fromDbMap(Map<String, dynamic> map)
  : id = map['id'],
    title = map['title'],
    ltlngLocation = map['ltlnglocation'],
    description = map['description'];
  Map<String, dynamic> toDbMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['ltlnglocation'] = ltlngLocation;
    map['description'] = description;
    return map;
  }
}

class ImageHandler {
  Future<Uint8List> _imgReadToBytes() async {
    var file = File.fromUri(Uri.parse(_filePath));
    return await file.readAsBytes();
  }

  Future<Image> decodeImageFromList(Uint8List bytes) async {
    final Codec codec = await PaintingBinding.instance!.instantiateImageCodec(bytes);
    final FrameInfo frameInfo = await codec.getNextFrame();
    return frameInfo.image;
  }
}