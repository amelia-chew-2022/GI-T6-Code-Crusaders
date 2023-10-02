import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import './editFoodItem.dart';
import 'dart:collection';
import 'package:http/http.dart' as http;
import './inventory.dart';


class FoodDetails extends StatefulWidget {
  @override
  State<FoodDetails> createState() => _DetailsState();

  const FoodDetails(
      {super.key,
      required this.email,
      required this.foodId,
      required this.food,
      required this.quantity,
      required this.units,
      required this.expiryDate,
      required this.category});

  final String email;
  final String foodId;
  final String food;
  final int quantity;
  final String units;
  final String expiryDate;
  final String category;
}

class _DetailsState extends State<FoodDetails> {
  final _formkey = GlobalKey<FormState>(); // creating a key for form
  
  Future<http.Response> deleteItem(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://127.0.0.1:5000/delete/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Container(
                                  child: IconButton(
                                      icon: Icon(Icons.chevron_left_rounded, size: 28),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      })),
                              Text(widget.food,
                                  style: const TextStyle(
                                    color: Color(0xFF003B2B),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  )),
                            ]),
                            Row(children: [
                              // Edit Food Item
                              Container(
                                  child: IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditFoodItem(
                                              email: widget.email,
                                              foodId: widget.foodId,
                                              food: widget.food,
                                              quantity: widget.quantity,
                                              units: widget.units,
                                              expiryDate: widget.expiryDate,
                                              category: widget.category)));
                                },
                              )),
                              // Delete Function
                              Container(
                                  child: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            scrollable: true,
                                            title: const Text("Delete: "),
                                            content: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Form(
                                                  child: Column(
                                                children: [
                                                  Text("Are you sure you want to delete " +  widget.food + "?"),
                                                  Padding(
                                                      padding: const EdgeInsets.all(10),
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          deleteItem(widget.foodId);
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    Inventory(email: widget.email)));
                                                        },
                                                        child: const Text('Delete'),
                                                        style: ElevatedButton.styleFrom(
                                                            minimumSize:const Size.fromHeight(50),
                                                            backgroundColor:Color( 0xFFD63434)))),
                                                  Padding(
                                                      padding:
                                                          const EdgeInsets.all( 10),
                                                      child: OutlinedButton(
                                                        onPressed: () {
                                                          Navigator.pop( context);
                                                        },
                                                        child: const Text(
                                                          'Cancel',
                                                          style: TextStyle(color: Color(0xFF000000)),
                                                        ),
                                                        style: OutlinedButton.styleFrom(
                                                            minimumSize: const Size.fromHeight(50),
                                                            backgroundColor:
                                                                Color( 0xFFFFFFFF)),
                                                      ))
                                                ],
                                              )),
                                            ));
                                      });
                                },
                              ))
                            ]),
                          ],
                        )),
                    const Divider(
                      color: Color(0xFF007F5C),
                      thickness: 0.5,
                    ),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text("Expiring on: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                Text(widget.expiryDate,
                                    style: TextStyle(fontSize: 14))
                              ],
                            )
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text("Quantity: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                Text(
                                    widget.quantity.toString() +
                                        " " +
                                        widget.units,
                                    style: TextStyle(fontSize: 14)),
                              ],
                            )
                          ],
                        )),
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Text("Category: ",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                Text(widget.category,
                                    style: TextStyle(fontSize: 14)),
                              ],
                            )
                          ],
                        ))
                  ]),
    )));
  }
}