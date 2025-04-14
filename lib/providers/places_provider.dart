import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths; 
import 'package:favorite_places/models/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlacesNotifier(): super(const []);

  void addPlace(String title, File image, PlaceLocation location) async {

    // just storing the image data properly on our device
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = PlaceModel(title: title, image: copiedImage, location: location);
    state = [newPlace, ...state]; //new place added would always be first appended, wouldn't be replaced
  }
}

final userPlacesProvider = StateNotifierProvider<UserPlacesNotifier,List<PlaceModel>> ((ref) => UserPlacesNotifier());