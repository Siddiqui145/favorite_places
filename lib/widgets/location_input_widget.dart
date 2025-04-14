import 'dart:convert';

import 'package:favorite_places/models/place_model.dart';
import 'package:favorite_places/screens/map_screen.dart';
import 'package:favorite_places/secrets/api_key.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

class LocationInputWidget extends StatefulWidget {
  const LocationInputWidget({super.key, required this.onSelectLocation});

  final void Function(PlaceLocation location) onSelectLocation;

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  PlaceLocation? pickedLocation;
  var isgettingLocation = false;

  String get locationImage {

    final lat = pickedLocation!.latitude;
    final lon = pickedLocation!.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$lat,$lon&key=$apiKey';
  }

  void getCurrentLocation() async {

    Location location = Location();

bool serviceEnabled;
PermissionStatus permissionGranted;
LocationData locationData;

serviceEnabled = await location.serviceEnabled();
if (!serviceEnabled) {
  serviceEnabled = await location.requestService();
  if (!serviceEnabled) {
    return;
  }
}

permissionGranted = await location.hasPermission();
if (permissionGranted == PermissionStatus.denied) {
  permissionGranted = await location.requestPermission();
  if (permissionGranted != PermissionStatus.granted) {
    return;
  }
}

    setState(() {
      isgettingLocation = true;
    });

      locationData = await location.getLocation();

      final latitude = locationData.latitude;
      final longitude = locationData.longitude;

      if (latitude == null || longitude == null){ //handling null so avoid warnings safe from issues
        return;
      }
  savePlace(latitude, longitude);
}

  Future<void> savePlace(double latitude, double longitude) async {
    final url = Uri.parse('https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey');

      final response = await http.get(url);
      final resData = json.decode(response.body);
      
      String address = 'Unknown location';
      if (resData['status'] == 'OK' && resData['results'].isNotEmpty) {
          address = resData['results'][0]['formatted_address'];
        }


    setState(() {
      pickedLocation = PlaceLocation(
        latitude: latitude, 
        longitude: longitude, 
        address: address);

        isgettingLocation = false;
    });
    widget.onSelectLocation(pickedLocation!);
  }

  void selectOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) => MapScreen()
      )
    );

    if (pickedLocation == null){
      return;
    }
    savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {

    Widget previewContent = Text('No Location chosen',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface
            ),);


    if (pickedLocation != null) {
      previewContent = Image.network(locationImage,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,);
    }

    if (isgettingLocation)            {
      previewContent = const CircularProgressIndicator();
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2)
              )
            ),
            child: previewContent
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: getCurrentLocation, 
                label: Text('Get User Location'),
                icon: Icon(Icons.location_on),),

              TextButton.icon(
                onPressed: selectOnMap, 
                label: Text('Select on Map'),
                icon: Icon(Icons.map),),
            ],
          )
        ],
      ),
    );
  }
}