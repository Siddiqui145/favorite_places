import 'package:flutter/material.dart';
import 'package:location/location.dart';

// AIzaSyBoGcwaQUSmNgcesK-6aoJzNNihJiAq6pI

class LocationInputWidget extends StatefulWidget {
  const LocationInputWidget({super.key});

  @override
  State<LocationInputWidget> createState() => _LocationInputWidgetState();
}

class _LocationInputWidgetState extends State<LocationInputWidget> {
  Location? pickedLocation;
  var isgettingLocation = false;

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

    setState(() {
      isgettingLocation = false;
    });
}

  @override
  Widget build(BuildContext context) {

    Widget previewContent = Text('No Location chosen',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface
            ),);

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
                onPressed: () {}, 
                label: Text('Select on Map'),
                icon: Icon(Icons.map),),
            ],
          )
        ],
      ),
    );
  }
}