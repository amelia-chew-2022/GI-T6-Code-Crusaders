import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:typed_data';

class ImagePickerButton extends StatefulWidget {
  final Function(Uint8List?) onImageSelected; // Accept a nullable Uint8List

  ImagePickerButton({required this.onImageSelected});

  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  Uint8List? selectedImageBytes; // Add this variable

  Future<void> pickImage() async {
    final bytes = await ImagePickerWeb.getImageAsBytes();
    setState(() {
      selectedImageBytes = bytes;
    });

    // Pass the selected image bytes to the parent widget
    widget.onImageSelected(selectedImageBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: pickImage,
          child: Text('Upload Photo'),
        ),
        SizedBox(
          height: 10,
        ),
        if (selectedImageBytes != null)
          Container(
            width: 200,
            height: 200,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.memory(
                selectedImageBytes!,
                fit: BoxFit.cover,
              ),
            ),
          )
        else
          Text(
            "No Image",
            style: TextStyle(fontSize: 20),
          ),
      ],
    );
  }
}
