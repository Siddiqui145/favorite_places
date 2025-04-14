import 'package:favorite_places/models/place_model.dart';
import 'package:favorite_places/screens/map_screen.dart';
import 'package:favorite_places/secrets/api_key.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({
    required this.place,
    super.key,
    });

  final PlaceModel place;

  String get locationImage {

    final lat = place.location.latitude;
    final lon = place.location.longitude;

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lon&zoom=16&size=600x300&maptype=roadmap&markers=color:blue%7Clabel:A%7C$lat,$lon&key=$apiKey';
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
        backgroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Image.file(
          place.image,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => 
                      MapScreen(
                      location: place.location,
                      isSelecting: false,
                    )));
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locationImage),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      Colors.black54
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                    )
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16
                  ),
                  child: Text(place.location.address,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                   color: Theme.of(context).colorScheme.onSurface
            )),
                )
              ],
            ))
        ],
      )
    );
  }
}