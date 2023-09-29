import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Map<String, dynamic>> fetchData() async {
  final response = await http.get(Uri.parse('http://127.0.0.1:8080/data'));

  if (response.statusCode == 200) {
    // Parse the JSON response
    final jsonData = jsonDecode(response.body);
    return jsonData;
  } else {
    throw Exception('Failed to fetch data');
  }
}

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Data from Flask'),
        ),
        body: FutureBuilder<Map<String, dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final data = snapshot.data!;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Name: ${data['name']}'),
                    Text('Age: ${data['age']}'),
                    Text('Email: ${data['email']}'),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(Test());
}
