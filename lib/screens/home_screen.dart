import 'package:favorite_places/screens/add_place_screen.dart';
import 'package:favorite_places/widgets/places_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
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
      body: PlacesWidget(places: []),
    );
  }
}