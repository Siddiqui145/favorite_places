import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths; 
import 'package:favorite_places/models/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sqflite/sqflite.dart' as sql;

class UserPlacesNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlacesNotifier(): super(const []);

  void addPlace(String title, File image, PlaceLocation location) async {

    // just storing the image data properly on our device
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = PlaceModel(title: title, image: copiedImage, location: location);

    // storing other information & data
    // database created
    final dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, 'places.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, title TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
      },
      version: 1
    );
    // once data base created above now inserting into local sql database
    db.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address
    });
    state = [newPlace, ...state]; //new place added would always be first appended, wouldn't be replaced
  }
}

final userPlacesProvider = StateNotifierProvider<UserPlacesNotifier,List<PlaceModel>> ((ref) => UserPlacesNotifier());