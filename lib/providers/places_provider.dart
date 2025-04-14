import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths; 
import 'package:favorite_places/models/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

class UserPlacesNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlacesNotifier(): super(const []);


  Future<Database> getDatabase() async {
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
    return db;
  }


  Future <void> loadPlaces() async {
    // sql query could have where for filtering in fetch
    final db = await getDatabase();
    final data = await db.query('Favorite_places');

    final savedPlaces = data.map((row) => PlaceModel(
      id: row['id'] as String,
      title: row['title'] as String, 
      image: File(row['image'] as String), 
      location: PlaceLocation(
        latitude: row['lat'] as double, 
        longitude: row['lng'] as double, 
        address: row['address'] as String))).toList();

        state = savedPlaces;
  }

  void addPlace(String title, File image, PlaceLocation location) async {

    // just storing the image data properly on our device
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = PlaceModel(title: title, image: copiedImage, location: location);

    final db = await getDatabase();
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