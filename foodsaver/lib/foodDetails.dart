import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

class FoodDetails extends StatefulWidget {
  @override
  State<FoodDetails> createState() => _DetailsState();

  const FoodDetails(
      {super.key,
      required this.food,
      required this.quantity,
      required this.units,
      required this.expiryDate,
      required this.category});
  final String food;
  final int quantity;
  final String units;
  final String expiryDate;
  final String category;
}

class _DetailsState extends State<FoodDetails> {
  final _formkey = GlobalKey<FormState>(); // creating a key for form

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
                                      icon: Icon(Icons.chevron_left_rounded,
                                          size: 28),
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
                                  Navigator.pop(context);
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
                                            title: const Text("Filter By: "),
                                            content: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Form(
                                                  child: Column(
                                                children: [
                                                  TextFormField(
                                                    decoration:
                                                        const InputDecoration(
                                                            icon: Icon(
                                                                Icons.sort)),
                                                  )
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
