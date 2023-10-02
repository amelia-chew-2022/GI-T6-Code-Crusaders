import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadWidget extends StatefulWidget {
  final Function(File?) onImageSelected; // Accept a nullable File

  ImageUploadWidget({required this.onImageSelected});

  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  XFile? image;
  final ImagePicker picker = ImagePicker();

  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = img;
      widget.onImageSelected(image != null
          ? File(image!.path)
          : null); // Convert to File and pass it to the callback
    });
  }

  void showImageSourceDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          title: Text('Please choose media to select'),
          content: Container(
            height: MediaQuery.of(context).size.height / 6,
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.gallery);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.image),
                      Text('From Gallery'),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getImage(ImageSource.camera);
                  },
                  child: Row(
                    children: [
                      Icon(Icons.camera),
                      Text('From Camera'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            showImageSourceDialog(context);
          },
          child: Text('Upload Photo'),
        ),
        SizedBox(
          height: 10,
        ),
        image != null
            ? Container(
                width: 200,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    File(image!.path),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Text(
                "No Image",
                style: TextStyle(fontSize: 20),
              ),
      ],
    );
  }
}
