import 'package:flutter/material.dart';

class ImageInputWidget extends StatefulWidget {
  const ImageInputWidget({super.key});

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {

  void takePicture(){}

  @override
  Widget build(BuildContext context) {

    //displaying a nice container to be able to add our images
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2) )
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,  //would keep centered from both sides hori, vert.
      child: TextButton.icon(
        icon: const Icon(Icons.camera),
        onPressed: takePicture, 
        label: Text('Take Picture')),
    );
  }
}