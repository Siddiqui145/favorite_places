import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInputWidget extends StatefulWidget {
  const ImageInputWidget({super.key});

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File? selectedImage;

  void takePicture() async {
    final imagePicker = ImagePicker();
    
    //we can use 2 buttons both source camera as well as gallery
    final pickedImage = await imagePicker.pickImage(source: ImageSource.camera, maxWidth: 600);

    if (pickedImage == null){
      return;
    }
    setState(() {
      selectedImage = File(pickedImage.path); //need to convert it into type as File
    });
  }

  @override
  Widget build(BuildContext context) {

    Widget content = TextButton.icon(
        icon: const Icon(Icons.camera),
        onPressed: takePicture, 
        label: Text('Take Picture'));

        if(selectedImage != null){
          content = GestureDetector(
            onTap: takePicture,
            child: Image.file(selectedImage!, fit: BoxFit.cover, width: double.infinity, height: double.infinity,));
        }

    //displaying a nice container to be able to add our images
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.2) )
      ),
      height: 250,
      width: double.infinity,
      alignment: Alignment.center,  //would keep centered from both sides hori, vert.
      child: content
    );
  }
}