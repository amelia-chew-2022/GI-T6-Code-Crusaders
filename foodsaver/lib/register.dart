import 'package:flutter/material.dart';
import './login.dart';
import 'package:flutter/gestures.dart';
import "dart:convert";
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formkey = GlobalKey<FormState>(); // creating a key for form
  final apiUrl = "http://127.0.0.1:5000/register";
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  TextEditingController confirmPwdController = TextEditingController();

  Future<void> sendPostRequest() async {
    var response = await http.post(Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": nameController.text,
          "email": emailController.text,
          "pwd": pwdController.text,
        }));

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Post created successfully!"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Failed to create post!"),
      ));
    }
  }


  @override
  Widget build(BuildContext context) {
    bool isFocused = false;
    
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.all(10.0),
                    child: const Text("Create New \nAccount",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ))),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFF007F5C),
                        )),
                        labelText: "Email",
                        suffixIcon: Icon(Icons.email),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Color(0xFF007F5C),
                        )),
                        labelText: "Name",
                        suffixIcon: Icon(Icons.food_bank),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: pwdController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF007F5C),
                          )),
                          labelText: "Password",
                          suffixIcon: Icon(Icons.password)),
                    )),
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: TextFormField(
                      controller: confirmPwdController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color(0xFF007F5C),
                          )),
                          labelText: "Confirm Password",
                          suffixIcon: Icon(Icons.password)),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the Inventory Page
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => Login())
                              );
                            sendPostRequest();

                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Color(0xFF003B2B)),
                        child: const Text("Register"),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'Have an account? ',
                        style: new TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Log In Here',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                      ),
                    ])))
              ],
            )),
      ),
    );
  }

}

