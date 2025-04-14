import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();
//  For constructing a unique identifier with the use of a package
//  this could be used and would generate based on version 4

class PlaceModel {
  final String id;
  final String title;
  final File image;

  PlaceModel({
    required this.title,
    required this.image
  }):id = uuid.v4();
}