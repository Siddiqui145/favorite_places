import 'package:favorite_places/providers/places_provider.dart';
import 'package:favorite_places/widgets/image_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final titleController = TextEditingController();

  void savePlace(){
    final enteredTitle = titleController.text;

    if (enteredTitle.isEmpty) {
      return;
    }

    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Place'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Title',
              ),
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              controller: titleController,
            ),
            const SizedBox(
              height: 16,
            ),
            ImageInputWidget(),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton.icon(
              onPressed: savePlace,
              icon: Icon(Icons.add, color: Colors.white,),
              label: Text('Add Place',
              style: TextStyle(color: Colors.white),))
          ],
        ),
      ),
    );
  }
}