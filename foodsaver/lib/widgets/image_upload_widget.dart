import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart' show MultipartFile;
import 'package:path/path.dart' as path;
import 'package:http_parser/http_parser.dart' show MediaType;

class ImageUploadWidget extends StatefulWidget {
  @override
  _ImageUploadWidgetState createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  String imagePath = ''; // Initialize with an empty string

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          imagePath =
              pickedFile.path; // Set imagePath to the selected file path
        });
      } else {
        // User canceled the image selection
        // Handle it as needed (e.g., show a message)
      }
    } catch (e) {
      // Handle any exceptions that may occur during image selection
      print('Error picking image: $e');
      // You can show an error message to the user if needed
    }
  }

  Future<void> _uploadImage() async {
    final Uri uploadUrl = Uri.parse(
        'YOUR_UPLOAD_URL_HERE'); // Replace with your server's upload URL

    try {
      final imageFile = File(imagePath);
      final imageStream = http.ByteStream(imageFile.openRead());
      final length = await imageFile.length();

      final fileName =
          path.basename(imageFile.path); // Get the basename of the file

      final request = http.MultipartRequest('POST', uploadUrl)
        ..files.add(
          http.MultipartFile(
            'image',
            imageStream,
            length,
            filename: fileName,
            contentType:
                MediaType('image', 'jpeg'), // Adjust the content type as needed
          ),
        );

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        // Image upload was successful
        // You can handle the response data here if the server returns any
        print('Image upload successful');
      } else {
        // Image upload failed
        // Handle the error, show a message to the user, etc.
        print('Image upload failed with status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle any exceptions that may occur during the upload
      print('Error uploading image: $e');
      // You can show an error message to the user if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          if (imagePath != null)
            Image.file(
              File(imagePath),
              width: 200,
              height: 200,
            ),
          ElevatedButton(
            onPressed: _pickImage,
            child: Text('Select Image'),
          ),
          ElevatedButton(
            onPressed: _uploadImage,
            child: Text('Upload Image'),
          ),
        ],
      ),
    );
  }
}
