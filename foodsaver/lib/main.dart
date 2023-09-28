import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  //dummy info
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Futter Demo',
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF0F5F2),
          useMaterial3: false),
      home: const Login(title: 'Login'),
    );
  }
}

class Login extends StatefulWidget {
  const Login({super.key, required this.title});
  final String title;

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
      // appBar: AppBar(
      //   // title: Text(widget.title),
      // ),
      body: Form(
        key: _formkey,
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
            child: Column(
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
                        horizontal: 15, vertical: 16),
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
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 16),
                    child: Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Navigate to the Inventory Page
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Inventory(email: emailController.text)));
                        },
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(150, 50.0),
                            backgroundColor: Color(0xFF003B2B)),
                        child: const Text("Submit"),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}

class Inventory extends StatelessWidget {
  const Inventory({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Welcome \n" + email,
                              style: const TextStyle(
                                color: Color(0xFF003B2B),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              )),
                          Container(
                              child: IconButton(
                            icon: Icon(Icons.logout),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ))
                        ],
                      )),
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("Inventory",
                              style: TextStyle(
                                color: Color(0xFF003B2B),
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              )),
                          Row(children: [
                            Container(
                                child: IconButton(
                              icon: Icon(Icons.sort),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )),
                            Container(
                                child: IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ))
                          ]),
                        ],
                      )
                      ),
                      Divider(
                        color: Color(0xFF007F5C),
                        thickness: 0.5,
                      ),
                ],
              ))),
    );
  }
}
