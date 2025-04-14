import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:favorite_places/widgets/places_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  late Future<void> placesFuture;

  @override
  void initState() {
    super.initState();
    placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }


  @override
  Widget build(BuildContext context) {
    final userPlaces = ref.read(userPlacesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites Places'),
        actions: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddPlaceScreen()));
          }, icon: Icon(Icons.add))
        ],
        backgroundColor: Colors.black,
      ),
      body: Padding(
      padding: EdgeInsets.all(16),
      child: FutureBuilder(
        future: placesFuture, 
        builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.waiting
          ? const Center(
            child: CircularProgressIndicator()
          )
          : PlacesWidget(places: userPlaces)
        ),
        ),
    );
  }
}