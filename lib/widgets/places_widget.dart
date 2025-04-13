import 'package:favorite_places/models/place_model.dart';
import 'package:flutter/material.dart';

class PlacesWidget extends StatelessWidget {
  const PlacesWidget({
    required this.places,
    super.key});

  final List<PlaceModel> places;

  @override
  Widget build(BuildContext context) {
    if (places.isEmpty){
      return Center(
        child: Text('No Places added yet!',
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface),),
      );
    }
    return ListView.builder(
      itemCount: places.length,
      itemBuilder: (context, index) {
        final place = places[index];

        return ListTile(
          title: Text(place.title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.onSurface
          ),),
        );
      },
    );
  }
}