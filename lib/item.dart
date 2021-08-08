import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart';
import 'dart:typed_data';
import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:flutter/painting.dart';
import 'package:sqflite/sqflite.dart';
import 'main.dart';

class Item {
  late int id;
  late String title;
  late LatLng ltlngLocation;
  late String description;
  List<Uint8List> images = [];

  Item(String title, LatLng ltlnglocation, String description) {
    this.id = itemId;
    this.title = title;
    this.ltlngLocation = ltlnglocation;
    this.description = description;
  }
  Item.fromDbMap(Map<String, dynamic> map)
  : id = map['id'],
    title = map['title'],
    ltlngLocation = map['ltlnglocation'],
    description = map['description'],
    images = map['images'];
  Map<String, dynamic> toDbMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['title'] = title;
    map['ltlnglocation'] = ltlngLocation;
    map['description'] = description;
    map['images'] = images;
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