import 'package:flutter/material.dart';

class AddFoodItem extends StatelessWidget {
  final _formkey = GlobalKey<FormState>(); 
  TextEditingController nameController = TextEditingController();
  TextEditingController expireDateController = TextEditingController();


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
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                              child: IconButton(
                            icon: Icon(Icons.chevron_left_rounded, size: 28),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )),
                          const Text("Add Items",
                              style: const TextStyle(
                                color: Color(0xFF003B2B),
                                fontSize: 24,
                                fontWeight: FontWeight.w700,
                              )),
                        ],
                      )),
                  Divider(
                    color: Color(0xFF007F5C),
                    thickness: 0.5,
                  ),




                ],
              ))),
    );
  }
}