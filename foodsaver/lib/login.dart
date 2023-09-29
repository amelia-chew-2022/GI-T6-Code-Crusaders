import 'package:flutter/material.dart';
import './inventory.dart';
import './register.dart';
import 'package:flutter/gestures.dart';

class Login extends StatefulWidget {
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formkey = GlobalKey<FormState>(); // creating a key for form
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();

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
                    child: const Text("Welcome \nBack",
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ))),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
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
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Email';
                        }
                        return null;
                      },
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 16),
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
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your Password';
                          }
                          return null;
                        })),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formkey.currentState!.validate()) {
                            // Navigate to the Inventory Page
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Inventory(
                                        email: emailController.text)));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Please fill input')));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Color(0xFF003B2B)),
                        child: const Text("Login"),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                        text: 'Don\'t have an account? ',
                        style: new TextStyle(color: Colors.black),
                      ),
                      TextSpan(
                        text: 'Register Here',
                        style: TextStyle(color: Colors.blue),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Register()));
                          },
                      ),
                    ])))
              ],
            )),
      ),
    );
  }
}
