import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();
//  For constructing a unique identifier with the use of a package
//  this could be used and would generate based on version 4


class PlaceLocation {
  final double longitude;
  final double latitude;
  final String address;

  PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class PlaceModel {
  final String id;
  final String title;
  final File image;
  final PlaceLocation location;

  PlaceModel({
    required this.title,
    required this.image,
    required this.location
  }):id = uuid.v4();
}

